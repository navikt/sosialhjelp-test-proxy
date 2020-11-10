FROM nginx:1.15
COPY default.conf /default.conf
COPY static /static
CMD envsubst '${PORT} ${DOMENE}' < /default.conf > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
