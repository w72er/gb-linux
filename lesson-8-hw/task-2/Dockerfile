FROM ubuntu:latest
MAINTAINER no name
RUN apt update && apt install -y \
    nginx \
    php-fpm \
    && rm -rf /var/lib/apt/lists/*
VOLUME ["/var/www/html", "/etc/nginx/sites-available/"]
ADD start.sh .
EXPOSE 80
#CMD ["nginx", "-g", "daemon off;"]
CMD bash start.sh

