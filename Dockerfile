FROM nginx:1.21.3
RUN apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*
COPY default.conf /default.conf
COPY static /static
RUN chmod 660 /etc/nginx/conf.d/default.conf
RUN chmod 770 /var/cache/nginx
CMD envsubst '${PORT} ${DOMENE}' < /default.conf > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
