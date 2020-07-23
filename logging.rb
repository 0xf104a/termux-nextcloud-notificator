# Pretty logging
require "config.rb"

def get_time
 Time.now.to_s
end

module Logging
 class <<self
    attr_accessor :file
 end
 GREEN = "\033[32m"
 BLUE = "\033[34m"
 ORANGE = "\033[33m"
 RED = "\033[31m"
 ENDC = "\033[39m\033[0m"
 BOLD = "\033[1m" 
 LEVELS = {"debug"=>4, 
	   "info" =>3,
           "warn" =>2,
           "error"=>1,
           "none" =>0}
 @file = nil
 def self.init()
   @file = Config::get("logging.file")
 end
 def self.info(message)
   loglevel=Config::get("logging.level")
   loglevel=LEVELS[loglevel]
   if loglevel<3 then
      return
   end
   self.write2file("INFO",message)
   print("\r#{BLUE}#{BOLD}INFO  #{ENDC+BOLD}| #{get_time}:#{ENDC}#{message}\n")
 end
 def self.debug(message)
   loglevel=Config::get("logging.level")
   loglevel=LEVELS[loglevel]
   if loglevel<4 then
      return
   end   
   self.write2file("DEBUG",message)
   print("\r#{GREEN}#{BOLD}DEBUG #{ENDC+BOLD}| #{get_time}:#{ENDC}#{message}\n")
 end 
 def self.warn(message)
   loglevel=Config::get("logging.level")
   loglevel=LEVELS[loglevel]
   if loglevel<2 then
      return
   end
   self.write2file("WARN",message)
   print("\r#{ORANGE}#{BOLD}WARN  #{ENDC+BOLD}| #{get_time}:#{ENDC}#{message}\n")
 end
 def self.error(message)
   loglevel=Config::get("logging.level")
   loglevel=LEVELS[loglevel]
   if loglevel<1 then
      return
   end
   self.write2file("ERROR",message)
   print("\r#{RED}#{BOLD}ERROR #{ENDC+BOLD}| #{get_time}:#{ENDC}#{message}\n")
 end
 def self.write2file(level,message)
   if @file.nil?
      return
   end
   message="[#{level}]:#{get_time}:#{message}\n"
   fname=@file
   open(fname, 'a') do |f|
      f << message
   end 
 end
end
