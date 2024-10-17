FROM php:8.2-apache
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
 && locale-gen "en_US.UTF-8"
ENV LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en

RUN apt-get update && \
    apt-get install -y \
      nodejs \
      r-base \
      libmariadb-dev

RUN R -e "install.packages(c('remotes', 'tidyverse', 'DBI', 'jsonlite', 'RMariaDB'), repos='https://cran.rstudio.com/')"
RUN R -e "remotes::install_github('dalejbarr/explan')"

ENV LC_ALL=C.UTF-8
