Используя grep, проанализировать файл /var/log/syslog, отобрав события
на своё усмотрение.

Листая логи, заметил что где-то возникают ошибки. Чтобы понять их
количество в системе просто отфильтровал строки с ошибками.

```text
a@md:/$ less /var/log/syslog 
a@md:/$ cat /var/log/syslog  | grep error
Jun 17 09:20:47 md gnome-shell[2363578]: libva error: /usr/lib/x86_64-linux-gnu/dri/iHD_drv_video.so init failed
Jun 17 10:27:33 md gnome-shell[2363578]: [2363570:2363594:0617/102733.498073:ERROR:connection_factory_impl.cc(429)] Failed to connect to MCS endpoint with error -105
Jun 17 10:29:04 md discord.desktop[41806]: rtc_log_set_paused error: monitor_option.is_none()
Jun 17 10:36:47 md discord.desktop[41806]: rtc_log_set_paused error: monitor_option.is_none()
Jun 17 10:51:13 md gnome-shell[2363578]: [2363570:2363594:0617/105113.666459:ERROR:connection_factory_impl.cc(429)] Failed to connect to MCS endpoint with error -105
Jun 17 10:52:17 md gnome-shell[2363578]: [2363570:2363594:0617/105217.926645:ERROR:connection_factory_impl.cc(429)] Failed to connect to MCS endpoint with error -105
Jun 17 11:29:29 md gnome-shell[2363578]: Fontconfig error: Cannot load default config file: No such file: (null)
```
