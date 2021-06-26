# 2. * Используя Dockerfile, собрать связку nginx + PHP-FPM в одном контейнере.
a@md:~/projects/my/gb-linux$ docker create -ti ubuntu bash
3e57471160d618adca58e32b1f83c5e1bc6aa3d8c5b8c90c330fa53b34535f70
a@md:~/projects/my/gb-linux$ docker start -ai 3e57471160d618adca58e32b1f83c5e1bc6aa3d8c5b8c90c330fa53b34535f70

https://askubuntu.com/questions/1274445/how-to-install-python-opencv-without-answering-the-quesitons

apt update
# apt install -y nginx # breaks
# DEBIAN_FRONTEND="noninteractive" apt install -y nginx # works
DEBIAN_FRONTEND="noninteractive" apt install -y nginx php-fpm # works
#apt install -y tzdata nginx - not workes

https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-ubuntu-18-04-ru

[cmd to run nginx](https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-docker/)
[General guidelines and recommendations](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

```shell
docker stop nginx-php
docker rm nginx-php
docker image rm nginx-php
echo 'Hi no name!' | sudo tee /var/www/html/index.html

docker build -t nginx-php .
#docker run -d --name nginx-php -p 8080:80 -v /var/www/html/:/var/www/html/ nginx-php # works

docker run -d --name nginx-php -p 8080:80 -v /var/www/html/:/var/www/html/  -v $(pwd)/etc/nginx/sites-available/:/etc/nginx/sites-available/ nginx-php
curl localhost:8080

```

```text
root@121443b72ef7:/# cat /etc/nginx/sites-available/default 
server {
	listen 80 default_server;
	listen [::]:80 default_server;

	root /var/www/html;

	# Add index.php to the list if you are using PHP
	index index.html index.htm index.nginx-debian.html;

	server_name _;

	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files $uri $uri/ =404;
	}

	# pass PHP scripts to FastCGI server
	#
	#location ~ \.php$ {
	#	include snippets/fastcgi-php.conf;
	#
	#	# With php-fpm (or other unix sockets):
	#	fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
	#	# With php-cgi (or other tcp sockets):
	#	fastcgi_pass 127.0.0.1:9000;
	#}
}

```
