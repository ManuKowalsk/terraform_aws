FROM php:8.2-apache

ENV DB_HOST localhost
ENV DB_USERNAME admin
ENV DB_PASSWORD Test2727$
ENV DB_NAME mydb

WORKDIR /var/www/html
COPY html/ ./

RUN docker-php-ext-install pdo pdo_mysql

EXPOSE 80