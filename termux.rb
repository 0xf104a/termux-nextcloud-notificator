
module Termux
   def self.open_url(url)
       `termux-open-url #{url.dump()}`
   end
   
   def self.notify(content, group, n_id, title, image)
       print("termux-notification -c #{content.dump()} --group #{group.dump()} -i #{n_id} --title #{title.dump()} --image-path #{image.dump()}\n")
       `termux-notification -c #{content.encode("utf-8").dump()} --title #{title.encode("utf-8").dump()} --id #{n_id} --group #{group.dump()}`
   end
end
