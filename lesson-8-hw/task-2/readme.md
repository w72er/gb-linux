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