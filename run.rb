#!/data/data/com.termux/files/usr/bin/env ruby
# Nextcloud notifcation poller for termux
# Prepare to loading modules

path = File.expand_path File.dirname(__FILE__) 
Dir.chdir(path)

$LOAD_PATH<<"."

# Load modules

require 'fileutils'
require 'logging.rb'
require 'auth.rb'
require 'notifications.rb'
require 'config.rb'

CONFIGFILE="/data/data/com.termux/files/usr/etc/nextcloud-notificator.yml"

# Load config and logging
Config::load(CONFIGFILE)
Logging::init() # Say logger that config is now available

FileUtils.mkdir_p(Config::get("app.cache")) # Create dirs if not exist

appPassword=Config::get("app.password") # Get place where to store auth data

if not File.file?(appPassword) then 
   # We have not been authenticated yet
   Logging::warn("It seems user was not authenticated before -- initiating authentication proccess")
   File.open(appPassword,"w+") do |file|
       file.write(Auth::authenticate(Config::get("cloud.endpoint")))
   end
end

password=File.read(appPassword)
Logging::info("Succesfully read app password from file")

begin
  Notifications::start_polling(Config::get("cloud.endpoint"), Config::get("cloud.user"), password, Config::get("polling.interval")) # Start polling
rescue Interrupt
  Logging::info("User requested stop. Exiting gracefully...")
end
