FROM php:8.1.1-apache
RUN docker-php-ext-install mysqli pdo pdo_mysql
