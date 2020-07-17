# Nextcloud notifcation poller for termux
$LOAD_PATH<<"."

require 'fileutils'
require 'logger.rb'
require 'auth.rb'
require 'notifications.rb'

USER="p01ar"
ENDPOINT="cloud.p01ar.net"

FileUtils.mkdir_p(".cache")

if not File.file?(".appPassword") then
   Logging::warn("It seems user was not authenticated before -- initiating authentication proccess")
   File.open(".appPassword","w+") do |file|
       file.write(Auth::authenticate(ENDPOINT))
   end
end

password=File.read(".appPassword")
Logging::info("Succesfully read app password from file")
Notifications::start_polling(ENDPOINT, USER, password)
