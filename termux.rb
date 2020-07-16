def sanitize(s)
   '"'+s.sub('"','\"')+'"'
end
module Termux
   def self.open_url(url)
       `termux-open-url #{url.dump()}`
   end
   
   def self.notify(content, group, n_id, title, image)
       print("termux-notification -c #{content.dump()} --group #{group.dump()} -i #{n_id} --title #{title.dump()} --image-path #{image.dump()}\n")
       `termux-notification -c #{sanitize(content)} --title #{sanitize(title)} --id #{n_id} --group #{sanitize(group)}`
   end
end
