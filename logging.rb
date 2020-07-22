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
 @file=nil
 def self.info(message)
   self.write2file("INFO",message)
   print("\r#{BLUE}#{BOLD}INFO  #{ENDC+BOLD}| #{get_time}:#{ENDC}#{message}\n")
 end
 def self.debug(message)
   self.write2file("DEBUG",message)
   print("\r#{GREEN}#{BOLD}DEBUG #{ENDC+BOLD}| #{get_time}:#{ENDC}#{message}\n")
 end 
 def self.warn(message)
   self.write2file("WARN",message)
   print("\r#{ORANGE}#{BOLD}WARN  #{ENDC+BOLD}| #{get_time}:#{ENDC}#{message}\n")
 end
 def self.error(message)
   self.write2file("ERROR",message)
   print("\r#{RED}#{BOLD}ERROR #{ENDC+BOLD}| #{get_time}:#{ENDC}#{message}\n")
 end
 def self.write2file(level,message)
   message="[#{level}]:#{get_time}:#{message}\n"
   fname=Config::get("logging.file")
   open(fname, 'w') do |f|
      f << message
   end 
 end
end
