# 1. Запустить контейнер с Ubuntu.

## Запуск контейнера с Ubuntu

Документация: Search the Docker Hub for `images`:
```text
a@md:~/projects/my/gb-linux$ docker search ubuntu
NAME          DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
ubuntu        Ubuntu is a Debian-based Linux operating sys…   12423     [OK]
```

Документация: Pull an `image` or a `repository` from a `registry`
```text
a@md:~/projects/my/gb-linux$ docker pull ubuntu
Using default tag: latest
latest: Pulling from library/ubuntu
c549ccf8d472: Pull complete 
Digest: sha256:aba80b77e27148d99c034a987e7da3a287ed455390352663418c0f2ed40417fe
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
```

Документация: List `images`
```text
a@md:~/projects/my/gb-linux$ docker image ls | grep ubuntu
REPOSITORY    TAG             IMAGE ID       CREATED         SIZE
ubuntu        latest          9873176a8ff5   7 days ago      72.7MB
```

Документация: The docker run `command` first creates a writeable container layer
over the specified image, and then starts it using the specified command.
```text
a@md:~/projects/my/gb-linux$ docker run -ti ubuntu /bin/bash
root@cdfd1e51e601:/# exit
exit
a@md:~/projects/my/gb-linux$
```

## Недостаток `docker run -ti ubuntu /bin/bash`

У подхода приведенного выше есть недостаток — увеличивается количество контейнеров:
```text
a@md:~/projects/my/gb-linux$ docker run -ti ubuntu /bin/bash
root@9e4f73dc22f5:/# exit
exit
a@md:~/projects/my/gb-linux$ docker run -ti ubuntu /bin/bash
root@00526c6c2102:/# exit
exit
a@md:~/projects/my/gb-linux$ docker ps -a | grep ubuntu
00526c6c2102   ubuntu   "/bin/bash"   6 seconds ago    Exited (0) 2 seconds ago    silly_lichterman
9e4f73dc22f5   ubuntu   "/bin/bash"   14 seconds ago   Exited (0) 11 seconds ago   zen_swartz
a@md:~/projects/my/gb-linux$ 
```

Хорошо бы иметь один контейнер, который запускать. Контейнер уже есть,
остается его лишь использовать (идея взята из
[документации](https://docs.docker.com/engine/reference/commandline/create/#create-and-start-a-container)).
Из листинга видно, что запуская контейнер, не увеличивается количество
контейнеров:
```text
a@md:~/projects/my/gb-linux$ docker start -ai 00526c6c2102
root@00526c6c2102:/# exit
exit
a@md:~/projects/my/gb-linux$ docker ps -a | grep ubuntu
00526c6c2102   ubuntu                                                   "/bin/bash"              5 minutes ago   Exited (0) 3 seconds ago                                                                                                                 silly_lichterman
9e4f73dc22f5   ubuntu                                                   "/bin/bash"              5 minutes ago   Exited (0) 5 minutes ago                                                                                                                 zen_swartz
a@md:~/projects/my/gb-linux$ 
```
