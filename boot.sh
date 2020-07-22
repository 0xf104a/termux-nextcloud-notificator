#!/data/data/com.termux/files/usr/bin/env bash
termux-toast "Booting nextcloud notificator..."
ruby /data/data/com.termux/files/usr/share/nextcloud-notificator/run.rb
read -n 1 -p "Press [ENTER] to close this session"
