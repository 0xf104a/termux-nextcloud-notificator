# Pretty logging
GREEN = "\033[32m"
BLUE = "\033[34m"
ORANGE = "\033[33m"
RED = "\033[31m"
ENDC = "\033[39m\033[0m"
BOLD = "\033[1m"

def get_time
 Time.now.to_s
end

module Logging
 def self.info(message)
   print("#{BLUE}#{BOLD}INFO  #{ENDC+BOLD}| #{get_time}:#{ENDC}#{message}\n")
 end
 def self.debug(message)
   print("#{GREEN}#{BOLD}DEBUG #{ENDC+BOLD}| #{get_time}:#{ENDC}#{message}\n")
 end 
 def self.warn(message)
   print("#{ORANGE}#{BOLD}WARN  #{ENDC+BOLD}| #{get_time}:#{ENDC}#{message}\n")
 end
 def self.error(message)
   print("#{RED}#{BOLD}ERROR #{ENDC+BOLD}| #{get_time}:#{ENDC}#{message}\n")
 end
end
