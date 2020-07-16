# Nextcloud notifcation poller for termux
$LOAD_PATH<<"."

require 'fileutils'
require 'auth.rb'
require 'notifications.rb'

USER="p01ar"
ENDPOINT="cloud.p01ar.net"

FileUtils.mkdir_p(".cache")

if not File.file?(".appPassword") then
   File.open(".appPassword","w+") do |file|
       file.write(Auth::authenticate(ENDPOINT))
   end
end

password=File.read(".appPassword")

Notifications::start_polling(ENDPOINT, USER, password)
