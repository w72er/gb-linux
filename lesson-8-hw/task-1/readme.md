```text
a@md:~/projects/my/gb-linux$ docker search ubuntu
NAME          DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
ubuntu        Ubuntu is a Debian-based Linux operating sys…   12423     [OK]
```

a@md:~/projects/my/gb-linux$ docker pull ubuntu
Using default tag: latest
latest: Pulling from library/ubuntu
c549ccf8d472: Pull complete 
Digest: sha256:aba80b77e27148d99c034a987e7da3a287ed455390352663418c0f2ed40417fe
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
a@md:~/projects/my/gb-linux$ docker run -d --name gb-ubuntu ubuntu
38a2def1d55928ced31f57eeae5d91054a49104971269e0d9998c30ffb749783
a@md:~/projects/my/gb-linux$ docker exec -ti gb-ubuntu bash
Error response from daemon: Container 38a2def1d55928ced31f57eeae5d91054a49104971269e0d9998c30ffb749783 is not running
a@md:~/projects/my/gb-linux$ docker run -ti --name gb-ubuntu ubuntu bash
docker: Error response from daemon: Conflict. The container name "/gb-ubuntu" is already in use by container "38a2def1d55928ced31f57eeae5d91054a49104971269e0d9998c30ffb749783". You have to remove (or rename) that container to be able to reuse that name.
See 'docker run --help'.
a@md:~/projects/my/gb-linux$ docker run -ti ubuntu /bin/bash
root@14f54a19cf89:/# exit
exit
a@md:~/projects/my/gb-linux$ docker run -ti --name gb-ubuntu ubuntu /bin/bash
docker: Error response from daemon: Conflict. The container name "/gb-ubuntu" is already in use by container "38a2def1d55928ced31f57eeae5d91054a49104971269e0d9998c30ffb749783". You have to remove (or rename) that container to be able to reuse that name.
See 'docker run --help'.
a@md:~/projects/my/gb-linux$ docker exec -ti gb-ubuntu bash
Error response from daemon: Container 38a2def1d55928ced31f57eeae5d91054a49104971269e0d9998c30ffb749783 is not running
a@md:~/projects/my/gb-linux$ docker run -ti gb-ubuntu /bin/bash
Unable to find image 'gb-ubuntu:latest' locally
docker: Error response from daemon: pull access denied for gb-ubuntu, repository does not exist or may require 'docker login': denied: requested access to the resource is denied.
See 'docker run --help'.
a@md:~/projects/my/gb-linux$ docker image ls
REPOSITORY                                           TAG             IMAGE ID       CREATED         SIZE
lab3.eltex.loc:5000/eccm/license-manager             dev             a0ce32cb70fb   3 hours ago     314MB
lab3.eltex.loc:5000/eccm/monitoring-service-worker   dev             12baa0267055   3 hours ago     275MB
lab3.eltex.loc:5000/eccm/data-presenter              dev             dc815b09dfe3   3 hours ago     298MB
lab3.eltex.loc:5000/eccm/device-manager              dev             fe576c24ed16   3 hours ago     311MB
lab3.eltex.loc:5000/eccm/diff-checker                dev             8206d6211294   3 hours ago     275MB
lab3.eltex.loc:5000/eccm/monitoring-adapter          dev             75e589eb0086   3 hours ago     312MB
lab3.eltex.loc:5000/eccm/communicator                dev             6724af5056d7   3 hours ago     309MB
lab3.eltex.loc:5000/eccm/identity-provider           dev             c8d6caca6392   3 hours ago     309MB
lab3.eltex.loc:5000/eccm/backend-ui                  dev             944eeeaf09bb   3 hours ago     289MB
lab3.eltex.loc:5000/eccm/cron-manager                dev             befa86035896   3 hours ago     316MB
lab3.eltex.loc:5000/eccm/map-manager                 dev             c2f714dd28a2   3 hours ago     303MB
lab3.eltex.loc:5000/eccm/upgrader                    dev             3c954fbeabb9   3 hours ago     307MB
lab3.eltex.loc:5000/eccm/upgrade-finish-checker      dev             d6fad8c264e3   3 hours ago     307MB
lab3.eltex.loc:5000/eccm/git-connector               dev             5a5d5811238a   3 hours ago     318MB
lab3.eltex.loc:5000/eccm/monitoring-service          dev             0e698f58ab9e   3 hours ago     276MB
lab3.eltex.loc:5000/eccm/web-gui                     dev             ae01c3db5b0f   4 hours ago     43MB
lab3.eltex.loc:5000/eccm/polemarch                   dev             68a2fabcf8a2   6 days ago      535MB
ubuntu                                               latest          9873176a8ff5   6 days ago      72.7MB
lab3.eltex.loc:5000/eccm/ory_configurator            dev             d162afd8ec4e   7 days ago      161MB
lab3.eltex.loc:5000/eccm/ory_oathkeeper              dev             0e8d639e32a7   7 days ago      25.1MB
lab3.eltex.loc:5000/eccm/ory_hydra                   dev             b28739b90ca0   7 days ago      29.5MB
lab3.eltex.loc:5000/eccm/upgrader                    <none>          64f202b14f3a   8 days ago      260MB
lab3.eltex.loc:5000/eccm/device-manager              <none>          9636f26146fa   8 days ago      263MB
lab3.eltex.loc:5000/eccm/upgrade-finish-checker      <none>          907aa37618e5   8 days ago      259MB
lab3.eltex.loc:5000/eccm/identity-provider           <none>          0ffa60684f59   8 days ago      263MB
lab3.eltex.loc:5000/eccm/monitoring-adapter          <none>          6dfe6c89aed4   8 days ago      265MB
lab3.eltex.loc:5000/eccm/monitoring-service-worker   <none>          79895ee7eb06   8 days ago      228MB
lab3.eltex.loc:5000/eccm/communicator                <none>          c59085c01dc3   8 days ago      262MB
lab3.eltex.loc:5000/eccm/map-manager                 <none>          d731f572b35a   8 days ago      256MB
lab3.eltex.loc:5000/eccm/cron-manager                <none>          8a92b842a6ac   8 days ago      269MB
lab3.eltex.loc:5000/eccm/license-manager             <none>          483386c1cd53   8 days ago      267MB
lab3.eltex.loc:5000/eccm/git-connector               <none>          5e0e3168f573   8 days ago      271MB
lab3.eltex.loc:5000/eccm/backend-ui                  <none>          48fbdeda65bc   8 days ago      242MB
lab3.eltex.loc:5000/eccm/monitoring-service          <none>          9c89d316fe69   8 days ago      229MB
lab3.eltex.loc:5000/eccm/diff-checker                <none>          399b42c12749   8 days ago      228MB
lab3.eltex.loc:5000/eccm/data-presenter              <none>          e3dd3498ed05   8 days ago      251MB
lab3.eltex.loc:5000/eccm/web-gui                     <none>          6d7b87835c47   9 days ago      43MB
lab3.eltex.loc:5000/eccm/polemarch                   <none>          21c1c230d0f4   9 days ago      535MB
lab3.eltex.loc:5000/eccm/ory_configurator            <none>          041274306937   2 weeks ago     161MB
lab3.eltex.loc:5000/eccm/ory_oathkeeper              <none>          e92ee0e6f76b   2 weeks ago     25.1MB
lab3.eltex.loc:5000/eccm/ory_hydra                   <none>          d9be9f04617d   2 weeks ago     29.5MB
lab3.eltex.loc:5000/identity-provider                dev             4d31dd5ba29f   2 weeks ago     261MB
lab3.eltex.loc:5000/identity-provider-nginx          dev             a926b5959e7b   2 weeks ago     133MB
lab3.eltex.loc:5000/ory_hydra                        dev             3895957441ba   2 weeks ago     29.5MB
lab3.eltex.loc:5000/eccm/web-gui                     <none>          01c2a63290b4   2 weeks ago     43MB
lab3.eltex.loc:5000/eccm/polemarch                   <none>          96cb9c6fc17c   2 weeks ago     535MB
lab3.eltex.loc:5000/eccm/ory_configurator            <none>          547b2ea6802d   2 weeks ago     143MB
lab3.eltex.loc:5000/eccm/ory_oathkeeper              <none>          ec0e53d75030   2 weeks ago     30.3MB
lab3.eltex.loc:5000/eccm/diff-checker                <none>          8918487c3bd0   2 weeks ago     228MB
lab3.eltex.loc:5000/eccm/upgrade-finish-checker      <none>          5bd05516583c   2 weeks ago     259MB
lab3.eltex.loc:5000/eccm/device-manager              <none>          18b3740b96d2   2 weeks ago     263MB
lab3.eltex.loc:5000/eccm/monitoring-adapter          <none>          1e6ca8e26a05   2 weeks ago     265MB
lab3.eltex.loc:5000/eccm/git-connector               <none>          88c020712719   2 weeks ago     270MB
lab3.eltex.loc:5000/eccm/backend-ui                  <none>          a3c591d71252   2 weeks ago     241MB
lab3.eltex.loc:5000/eccm/license-manager             <none>          98f33db6e64b   2 weeks ago     267MB
lab3.eltex.loc:5000/eccm/monitoring-service          <none>          406a9ccae99d   2 weeks ago     229MB
lab3.eltex.loc:5000/eccm/data-presenter              <none>          49e1dc2f6e7b   2 weeks ago     251MB
lab3.eltex.loc:5000/eccm/cron-manager                <none>          c3d3ccc2cd6f   2 weeks ago     268MB
lab3.eltex.loc:5000/eccm/upgrader                    <none>          7ae4d9105849   2 weeks ago     260MB
lab3.eltex.loc:5000/eccm/monitoring-service-worker   <none>          3905bbe34083   2 weeks ago     228MB
lab3.eltex.loc:5000/eccm/communicator                <none>          d850f9b95db2   2 weeks ago     262MB
hub.eltex-co.ru/eccm/rabbitmq                        3-management    246db2517862   4 weeks ago     186MB
hub.eltex-co.ru/eccm/postgres                        12.5            5fa7773911d6   4 months ago    314MB
portainer/portainer-ce                               latest          96a1c6cc3d15   4 months ago    209MB
hub.eltex-co.ru/eccm/pgbouncer                       1.14.0          f10587112917   6 months ago    17.7MB
oryd/hydra                                           v1.4.2-alpine   0e109750cf69   14 months ago   29.5MB
lab3.eltex.loc:5000/eccm/monitoring-web              dev             58b29c6a40fa   15 months ago   135MB
lab3.eltex.loc:5000/eccm/monitoring-server           dev             71c0bbdcbc0e   15 months ago   33.6MB
a@md:~/projects/my/gb-linux$ docker image ls | grep ubuntu
ubuntu                                               latest          9873176a8ff5   6 days ago      72.7MB
a@md:~/projects/my/gb-linux$ docker create --name gb-docker ubuntu
fb66a27cb38c6c6c6d786ab2319ca8109d353c15b393ae3768b76260e8c2181d
a@md:~/projects/my/gb-linux$ docker ps -a | ubuntu
ubuntu: команда не найдена
a@md:~/projects/my/gb-linux$ docker ps -a | grep ubuntu
fb66a27cb38c   ubuntu                                                   "bash"                   24 seconds ago   Created                                                                                                                                   gb-docker
14f54a19cf89   ubuntu                                                   "/bin/bash"              8 minutes ago    Exited (0) 8 minutes ago                                                                                                                  pedantic_raman
38a2def1d559   ubuntu                                                   "bash"                   11 minutes ago   Exited (0) 11 minutes ago                                                                                                                 gb-ubuntu
a@md:~/projects/my/gb-linux$ docker run -ti gb-ubuntu /bin/bash
Unable to find image 'gb-ubuntu:latest' locally
docker: Error response from daemon: pull access denied for gb-ubuntu, repository does not exist or may require 'docker login': denied: requested access to the resource is denied.
See 'docker run --help'.
a@md:~/projects/my/gb-linux$ docker run -ti gb-docker /bin/bash
Unable to find image 'gb-docker:latest' locally
docker: Error response from daemon: pull access denied for gb-docker, repository does not exist or may require 'docker login': denied: requested access to the resource is denied.
See 'docker run --help'.
a@md:~/projects/my/gb-linux$ docker exec -ti gb-docker /bin/bash
Error response from daemon: Container fb66a27cb38c6c6c6d786ab2319ca8109d353c15b393ae3768b76260e8c2181d is not running
a@md:~/projects/my/gb-linux$ docker start -ti gb-docker /bin/bash
unknown shorthand flag: 't' in -ti
See 'docker start --help'.
a@md:~/projects/my/gb-linux$ docker start -d gb-docker /bin/bash
unknown shorthand flag: 'd' in -d
See 'docker start --help'.
a@md:~/projects/my/gb-linux$ docker start -d gb-docker
unknown shorthand flag: 'd' in -d
See 'docker start --help'.
a@md:~/projects/my/gb-linux$ docker start gb-docker
gb-docker
a@md:~/projects/my/gb-linux$ docker exec -ti gb-docker /bin/bash
Error response from daemon: Container fb66a27cb38c6c6c6d786ab2319ca8109d353c15b393ae3768b76260e8c2181d is not running
a@md:~/projects/my/gb-linux$ 
