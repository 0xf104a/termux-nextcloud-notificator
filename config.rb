require 'yaml'
require 'logging.rb'

module Config
  class <<self
    attr_accessor :config_fname
    attr_accessor :config
  end
  
  @config_fname = nil
  @config = {}

  def self.load(fname='config.yml')
    begin
      @config = YAML.parse_file(fname).to_ruby
      @config_fname = fname
      Logging::info("Succesfully parsed config")
    rescue Exception => e
      Logging::error("Failed to parse config: #{e.message}")
    end
  end

  def self.get(var_name)
    if @config.length==0 then
       Logging::error("Config is empty. This can lead to further errors. Please check that configuration file is correct.")
    end
    path=var_name.split(".")
    context = @config
    path.each do |section|
       begin 
        if not context.has_key(section) then
           Logging::error("Failed to find #{var_name} in config")
           return nil
        end
       rescue Exception => e
           Logging::error("Failed to parse config: #{e.message}")
           return nil
       end
       context=context[section]
    end
  end
end
