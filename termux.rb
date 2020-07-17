require 'logging.rb'
def sanitize(s)
   '"'+s.sub('"','\"')+'"'
end
module Termux
   def self.open_url(url)
       IO::popen(["termux-open-url",url])
   end
   
   def self.notify(content, group, n_id, title, image)
        Logging::debug("termux-notification -c #{sanitize(content)} --title #{sanitize(title)} --id #{n_id} --group #{sanitize(group)}\n")
	IO::popen(["termux-notification", "--sound", "-c",content, "--title", title, "--id", n_id.to_s, "--group", "group"])
   end
end
