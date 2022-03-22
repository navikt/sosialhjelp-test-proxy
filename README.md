# Søknad om økonomisk sosialhjelp - test proxy

Reverse proxy for åpne testapplikasjoner.

# Oppsett av apper

For at proxyen skal route til riktig app på baksiden må det legges til config for appen i `default.conf`. Eks:

```conf
# Redirect for å legge på trailing slash på base-urler
location /sosialhjelp/soknad {
    return 302 https://digisos${DOMENE_PA_UTSIDEN}/sosialhjelp/soknad/;
}
```

```conf
# Reverse proxy til intern app-ingress
location /sosialhjelp/soknad/ {
    proxy_set_header Host sosialhjelp-soknad${DOMENE_PA_INNSIDEN};
    proxy_pass https://sosialhjelp-soknad${DOMENE_PA_INNSIDEN}/sosialhjelp/soknad/;
    proxy_ssl_server_name on;
    proxy_http_version 1.1;
}
```

Proxyen forutsetter at app-ingresser er postfixet med enten `-dev` eller `-mock`, eks `https://sosialhjelp-veiviser-mock.dev.nav.no/sosialhjelp`.
