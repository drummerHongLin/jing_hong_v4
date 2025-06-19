FROM nginx:stable-alpine

COPY . /usr/share/nginx/html
ADD default.conf /etc/nginx/html

EXPOSE 80

WORKDIR /usr/share/nginx/html

RUN chmod -R a+rx *