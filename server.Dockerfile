FROM php:8.1.1-apache
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN apt-get update && \
    apt-get install -y \
      r-base \
      libcurl4-openssl-dev \
      libssl-dev

RUN R -e "install.packages(c('tidyverse', 'DBI', 'jsonlite'), repos='https://cran.rstudio.com/')"
