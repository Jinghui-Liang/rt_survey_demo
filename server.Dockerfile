FROM php:8.1.1-apache
 RUN docker-php-ext-install mysqli pdo pdo_mysql
 RUN apt-get update && \
     apt-get install -y \
       nodejs \
       r-base

RUN R -e "install.packages(c('tidyverse', 'DBI', ‘jsonlite’), repos='https://cran.rstudio.com/')"
