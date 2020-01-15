FROM node:12.8.1 as node-builder

#FROM nginx:1.15
#COPY default.conf /etc/nginx/conf.d/default.conf
#CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'

FROM navikt/pus-decorator
ENV APPLICATION_NAME=sosialhjelp-test-proxy
ENV CONTEXT_PATH=sosialhjelp
COPY decorator.yaml /decorator.yaml