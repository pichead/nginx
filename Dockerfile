FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY html /usr/share/nginx/html
COPY sites-enabled/ /etc/nginx/conf.d/
COPY ssl/ /etc/ssl/

EXPOSE 80
