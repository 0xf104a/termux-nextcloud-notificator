def sanitize(s)
   '"'+s.sub('"','\"')+'"'
end
module Termux
   def self.open_url(url)
       `termux-open-url #{url.dump()}`
   end
   
   def self.notify(content, group, n_id, title, image)
        print("termux-notification -c #{sanitize(content)} --title #{sanitize(title)} --id #{n_id} --group #{sanitize(group)}\n")
	IO::popen(["termux-notification", "-c",content, "--title", title, "--id", n_id, "--group", "group"])`
   end
end
