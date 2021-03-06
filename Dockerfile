FROM nginx:1.15
RUN apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*
COPY default.conf /default.conf
COPY static /static
CMD envsubst '${PORT} ${DOMENE}' < /default.conf > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
