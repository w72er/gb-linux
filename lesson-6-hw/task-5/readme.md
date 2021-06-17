Создать разовое задание на перезагрузку операционной системы, используя `at`.

Кратко

```text
a@md:/$ sudo sh -c 'echo "reboot" | at 12:50pm 06/17/2021'
```

Подробно

* команда `echo "reboot" | at 11:06am 03/20/2020` завершается с ошибкой
* ошибка не может быть отправлена, поскольку нет утилиты `/bin/mail`
* email следующий: `Interactive authentication required.`
* запускаем `sudo at` не потеряв `pipe` следующим образом `sudo sh -c 'echo "reboot" | at 12:50pm 06/17/2021'`

```text
a@md:/$ echo "reboot" | at 11:06am 03/20/2020
at: refusing to create job destined in the past
a@md:/$ echo "reboot" | at 12:25pm 06/17/2021
warning: commands will be executed using /bin/sh
job 1 at Thu Jun 17 12:25:00 2021
a@md:/$ 
a@md:/$ atq
1       Thu Jun 17 12:25:00 2021 a a
a@md:/$ atq
a@md:/$ 
a@md:/$ tail -500 /var/log/syslog
Jun 17 12:25:00 md atd[2538828]: Exec failed for mail command: No such file or directory

https://serverfault.com/questions/782438/at-command-exec-failed-for-mail-command-no-such-file-or-directory
a@md:/$ sudo apt-get install s-nail
a@md:/$ sudo apt-get purge s-nail
# https://www.linux.org.ru/forum/admin/14498443
# Поставьте пакет mailx. Sendmail не нужен, нужна команда /bin/mail.

a@md:/$ sudo apt-get install bsd-mailx
только локальное использование
local.org

a@md:/$ tail -f /var/log/syslog
Jun 17 12:38:59 md systemd[5482]: var-lib-docker-overlay2-3ee8cb029f7f1627f8c91ea7a1d393497ac20cc0b6d3fe5543806fa427abb812-merged.mount: Succeeded.
Jun 17 12:39:00 md postfix/pickup[2553091]: 49986501B45: uid=1000 from=<a>
Jun 17 12:39:00 md postfix/cleanup[2555715]: 49986501B45: message-id=<20210617053900.49986501B45@md.eltex.loc>
Jun 17 12:39:00 md postfix/qmgr[2553092]: 49986501B45: from=<a@local.org>, size=540, nrcpt=1 (queue active)
Jun 17 12:39:00 md postfix/local[2555717]: 49986501B45: to=<a@local.org>, orig_to=<a>, relay=local, delay=0.04, delays=0.03/0/0/0.01, dsn=2.0.0, status=sent (delivered to mailbox)
Jun 17 12:39:00 md postfix/qmgr[2553092]: 49986501B45: removed
Jun 17 12:39:03 md systemd[1]: run-docker-runtime\x2drunc-moby-771ce31da9a48a276b0d1a385146fbc27b90dd471759c45307fa017071c7ca6d-runc.QkJKBX.mount: Succeeded.
Jun 17 12:39:04 md systemd[5482]: run-docker-runtime\x2drunc-moby-b8130242b12efbeb7b2ac4a667bd4a818c683cc36a2fbeb6467d229ee24efd87-runc.UfjFcB.mount: Succeeded.
qJun 17 12:39:09 md systemd[1]: run-docker-runtime\x2drunc-moby-277d8b71e97bad59cfde683c57c358421ff8478454b28ccc274b25d293256f97-runc.4E68cH.mount: Succeeded.

a@md:/$ cat /var/mail/a
From a@local.org  Thu Jun 17 12:39:00 2021
Return-Path: <a@local.org>
X-Original-To: a
Delivered-To: a@local.org
Received: by md.eltex.loc (Postfix, from userid 1000)
        id 49986501B45; Thu, 17 Jun 2021 12:39:00 +0700 (+07)
Subject: Output from your job        3
To: a@local.org
Message-Id: <20210617053900.49986501B45@md.eltex.loc>
Date: Thu, 17 Jun 2021 12:39:00 +0700 (+07)
From: a <a@local.org>

Failed to set wall message, ignoring: Interactive authentication required.
Failed to reboot system via logind: Interactive authentication required.
Failed to open initctl fifo: Отказано в доступе
Failed to talk to init daemon.


a@md:/$ sudo sh -c 'echo "reboot" | at 12:50pm 06/17/2021'

a@md:/$ cat /var/log/syslog | grep '12:50:0'
Jun 17 12:50:00 md systemd[1]: Stopping Session 2 of user a.
Jun 17 12:50:00 md systemd[1]: Removed slice system-getty.slice.
Jun 17 12:50:00 md systemd[1]: Removed slice system-modprobe.slice.
Jun 17 12:50:00 md systemd[1]: Stopped target Graphical Interface.
Jun 17 12:50:00 md systemd[1]: Stopped target Multi-User System.
Jun 17 12:50:00 md systemd[1]: Stopped target Login Prompts.
Jun 17 12:50:00 md systemd[1]: Stopped target Sound Card.
Jun 17 12:50:00 md systemd[1]: Stopped target Timers.
Jun 17 12:50:00 md systemd[1]: anacron.timer: Succeeded.
Jun 17 12:50:00 md systemd[1]: Stopped Trigger anacron every hour.
Jun 17 12:50:00 md systemd[1]: apt-daily-upgrade.timer: Succeeded.
Jun 17 12:50:00 md systemd[1]: Stopped Daily apt upgrade and clean activities.
Jun 17 12:50:00 md systemd[1]: apt-daily.timer: Succeeded.
Jun 17 12:50:00 md systemd[1]: Stopped Daily apt download activities.
```
