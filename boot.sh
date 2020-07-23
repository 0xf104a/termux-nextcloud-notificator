#!/data/data/com.termux/files/usr/bin/env bash
termux-toast "Booting nextcloud notificator..."
ruby /data/data/com.termux/files/usr/share/nextcloud-notificator/run.rb
termux-toast "Nextcloud notificator has died"
read -n 1 -p "Press [ENTER] to close this session"
