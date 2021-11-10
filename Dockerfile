FROM nginxinc/nginx-unprivileged:1.20
COPY default.conf /default.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY static /static
RUN chmod 660 /etc/nginx/conf.d/default.conf
CMD envsubst '${PORT} ${DOMENE}' < /default.conf > /etc/nginx/conf.d/default.conf && cat /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
