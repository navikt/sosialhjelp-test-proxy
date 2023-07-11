FROM nginxinc/nginx-unprivileged:1.25.1
COPY default.conf /default.conf
COPY static /static
RUN chmod 660 /etc/nginx/conf.d/default.conf
CMD envsubst '${PORT} ${DOMENE_PA_INNSIDEN} ${DOMENE_PA_UTSIDEN}' < /default.conf > /etc/nginx/conf.d/default.conf && cat /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
