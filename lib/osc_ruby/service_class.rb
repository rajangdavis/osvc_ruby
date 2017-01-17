require 'osc_ruby/client'
require 'osc_ruby/query_module'
require 'osc_ruby/validations_module'
require 'osc_ruby/class_factory_module'
require 'json'
require 'uri'
require_relative '../ext/string'

module OSCRuby
	
	class ServiceClass

		include QueryModule
		include ValidationsModule
		include ClassFactoryModule

	    def self.url

	    	self.to_s.split('::')[1].camel_case_lower

	    end
	    
	    def create(client,return_json = false)

	    	ClassFactoryModule.create(client,self,self.class.url,return_json)

	    end

	    
	    def self.find(client,id = nil,return_json = false)

	    	ClassFactoryModule.find(client,id,url,return_json,self)

	    end

	    
	    def self.all(client, return_json = false)

	    	ClassFactoryModule.all(client,url,return_json,self)

	    end

	    
	    def self.where(client, query = '', return_json = false)

			ClassFactoryModule.where(client,query,url,return_json,self)

	    end

	    
	    def update(client, return_json = false)

	    	ClassFactoryModule::update(client,self,self.class.url,return_json)

	    end


	    def destroy(client, return_json = false)

	    	ClassFactoryModule.destroy(client,self,self.class.url,return_json)

	    end

	end

end