#!/bin/bash
service apache2 start
php artisan migrate
php artisan serve --host=0.0.0.0
