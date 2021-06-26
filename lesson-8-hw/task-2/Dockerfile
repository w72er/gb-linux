FROM ubuntu:latest
MAINTAINER Aleksandr Makarevich
RUN apt update && apt install -y \
    nginx \
    php-fpm \
    && rm -rf /var/lib/apt/lists/*
VOLUVE ["/var/www/html", "/etc/nginx/sites-available/"]
# ADD etc/nginx/sites-available/default /etc/nginx/sites-available/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
