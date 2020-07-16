# Nextcloud notifcation poller for termux
$LOAD_PATH<<"."

require 'auth.rb'
require 'notifications.rb'

USER="user"
ENDPOINT="cloud.example.com"

FileUtils.mkdir_p(".cache")

if not File.file?(".appPassword") then
   File.open(".appPassword","w+") do |file|
       file.write(Auth::authenticate(ENDPOINT))
   end
end

password=File.read(".appPassword")

Notifications::start_polling(ENDPOINT, USER, password)
