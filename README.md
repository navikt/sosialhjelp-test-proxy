# Test-proxy for økonomisk sosialhjelp

Reverse proxy for testing av applikasjoner for økonomisk sosialhjelp

### Formål

Formålet med proxy-en er å gjøre det enkelt å sette opp mockede applikasjoner på
Heroku for manuell ekstern testing og automatisert nettlesertesting i byggejobber. I
tillegg er den en avlastning for interne miljøer, da kodeendringer som ikke berører
integrasjoner mot andre tjenester kan testes ute i et miljø, uten å legge beslag på
et av de få faste testmiljøene.

### Deployment

Ved første deployment til en ny applikasjon på Heroku, må vi fortelle Heroku hva slags
applikasjon som skal deployes. Denne applikasjonen er en Docker-container, og vi bruker
derfor følgende kommando:

```
heroku stack:set container
```

Det vil deretter være mulig å knytte applikasjonen på Heroku til dette repoet i navikt-
organisasjonen og deploye fra Heroku dashboardet.

### Routing

For hver tjeneste defineres det en default frontend og backend:

- `https://digisos-test.com/soknadsosialhjelp/` -> `https://soknadsosialhjelp.herokuapp.com/soknadsosialhjelp/`
- `https://digisos-test.com/soknadsosialhjelp-server/` -> `https://soknadsosialhjelp-server.herokuapp.com/soknadsosialhjelp-server/`

I tillegg defineres en omskrivningsregel for å koble frontend og backend i et
vilkårlig antall dynamiske "miljøer":

- `https://digisos-test.com/en-ny-feature/soknadsosialhjelp/` -> `https://en-ny-feature.herokuapp.com/soknadsosialhjelp/`
- `https://digisos-test.com/en-ny-feature/soknadsosialhjelp-server/` -> `https://en-ny-feature-server.herokuapp.com/soknadsosialhjelp-server/`

(En forutsetning for at dette skal virke er at applikasjonene er context path-agnostiske.)

For å slippe å bygge en ny backend ved endringer kun i frontend, routes kall mot frontend
prefixet med `-/` mot default backend:

- `https://digisos-test.com/-/en-ny-feature/soknadsosialhjelp/` -> `https://en-ny-feature.herokuapp.com/soknadsosialhjelp/`
- `https://digisos-test.com/-/en-ny-feature/soknadsosialhjelp-server/` -> `https://soknadsosialhjelp-server.herokuapp.com/soknadsosialhjelp-server/`

(**TODO**: Dette må også implementeres i resolving av API-path frontend, og er foreløpig
kun implementert med vanlig omskrivningsregel.)
