#!/bin/env ruby
require 'yaml'

def get_environment(node_name)

	hostname = node_name.split('.')[0]	
	env_hostname = hostname.gsub(/\d+/,'').reverse[0]
	case env_hostname
	when "h"
		env = {:environment => 'homolog'}.to_yaml 
	when "d"
		env = {:environment => 'development'}.to_yaml 
	when "p"
		tmp = hostname.gsub(/\d+/,'').reverse[1]
		if(tmp == "p")
			env = {:environment => 'pre-prod'}.to_yaml
		else
			env = {:environment => 'production'}.to_yaml
		end
	end
	env
end

def get_tag(node_name,yml)
	
	hostname = node_name.split('.')[0]
	yaml = YAML.load(yml)
	env  = yaml[:environment]
	case env
	when "homolog"
		tag = hostname.gsub('ceal','').gsub(/h\d+/ ,'')
	when "development"
		tag = hostname.gsub('ceal','').gsub(/d\d+/ ,'')
	when "production"
		tag = hostname.gsub('ceal','').gsub(/p\d+/ ,'')
	when "pre-prod"
		tag = hostname.gsub('ceal','').gsub(/pp\d+/ ,'')
	end
	
	yaml[:tag] = tag
	yaml.to_yaml
end

def get_yaml(node_name)
	yaml = get_environment(node_name)
	#yaml = get_tag(node_name,tmp_yaml)
end

yaml = get_yaml(ARGV[0])
puts yaml
