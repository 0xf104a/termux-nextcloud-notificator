#!/data/data/com.termux/files/usr/bin/env ruby
# Nextcloud notifcation poller for termux
$LOAD_PATH<<"."

require 'fileutils'
require 'logging.rb'
require 'auth.rb'
require 'notifications.rb'
require 'config.rb'

CONFIGFILE="/data/data/com.termux/files/usr/etc/nextcloud-notificator.yml"

Config::load(CONFIGFILE)
Logging::init()

FileUtils.mkdir_p(Config::get("app.cache"))

appPassword=Config::get("app.password")

if not File.file?(appPassword) then
   Logging::warn("It seems user was not authenticated before -- initiating authentication proccess")
   File.open(appPassword,"w+") do |file|
       file.write(Auth::authenticate(Config::get("cloud.endpoint")))
   end
end

password=File.read(appPassword)
Logging::info("Succesfully read app password from file")
begin
  Notifications::start_polling(Config::get("cloud.endpoint"), Config::get("cloud.user"), password, Config::get("polling.interval"))
rescue Interrupt
  Logging::info("User requested stop. Exiting gracefully...")
end
