FROM php:7.2-apache

RUN apt-get update && \
    apt-get install -y --no-install-recommends 
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Configure Apache & clean
RUN a2enmod rewrite  
# ======= composer =======
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get install -y git zip unzip

# php:7.2-apache image set workdir /var/www/html chnage to /app
WORKDIR /app
RUN composer create-project --prefer-dist laravel/laravel app "5.8.*"
RUN chmod -R 777 /app
#laravel instalation file in /app name directory app. so file in /app/app . so workdir change to /app/app to artisan file and laravel file
WORKDIR /app/app
RUN php artisan make:auth
ADD ./run.sh /app/app
CMD ["./run.sh"]