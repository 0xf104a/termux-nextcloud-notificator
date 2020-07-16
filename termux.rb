
module Termux
   def open_url(url)
       `termux-open-url #{url.dump()}`
   end
   
   def notify(content, group, id, title, image)
	`termux-notification -c #{content.dump()} --group #{group.dump()} -i #{id} --title #{title.dump()} --image-path #{image.dump()}`
   end
end
