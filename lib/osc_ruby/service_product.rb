require 'osc_ruby/client'
require 'osc_ruby/query_module'
require 'osc_ruby/validations_module'
require 'osc_ruby/class_factory_module'
require 'json'
require 'uri'

module OSCRuby
	
	class ServiceProduct

		include QueryModule
		include ValidationsModule
		include ClassFactoryModule
		
		attr_accessor :names,:parent,:displayOrder,:adminVisibleInterfaces,:endUserVisibleInterfaces,:id,:lookupName,:createdTime,:updatedTime,:name

	    def initialize(attributes = nil)

    		@names = []
			@adminVisibleInterfaces = []
			@endUserVisibleInterfaces = []

			if attributes.nil?

				@parent = {}
				@displayOrder = 1

			else

				@id = attributes["id"]
				@lookupName = attributes["lookupName"]
				@createdTime = attributes["createdTime"]
				@updatedTime = attributes["updatedTime"]
				@displayOrder = attributes["displayOrder"]
				@name = attributes["name"]
				@parent = attributes["parent"]

			end

	    end

	    
	    def create(client,return_json = false)

	    	ClassFactoryModule.create(client,self,"/serviceProducts",return_json,OSCRuby::ServiceProduct)

	    end

	    
	    def self.find(client,id = nil,return_json = false)

	    	ClassFactoryModule.find(client,id,'serviceproducts',return_json,OSCRuby::ServiceProduct)

	    end

	    
	    def self.all(client, return_json = false)

	    	ClassFactoryModule.all(client,'serviceproducts',return_json,OSCRuby::ServiceProduct)

	    end

	    
	    def self.where(client, query = '', return_json = false)

			ClassFactoryModule.where(client,query,'serviceproducts',return_json,OSCRuby::ServiceProduct)

	    end

	    
	    def update(client, return_json = false)

	    	ClassFactoryModule::update(client,self,"serviceProducts",return_json)

	    end


	    def destroy(client, return_json = false)

	    	ClassFactoryModule.destroy(client,self,'serviceProducts',return_json)

	    end


	    

	    # Convenience Methods for making the CRUD operations nicer to use

		def set_attributes(response_body)

			self.id = response_body["id"]

    		self.name = response_body["lookupName"]

    		self.lookupName = response_body["lookupName"]

			self.displayOrder = response_body["displayOrder"]

			if !response_body["parent"].nil?

				self.parent = response_body["parent"]["links"][0]["href"].split('/').pop.to_i

			else

				self.parent = nil

			end

		end

		def update_attributes(updated_product)

			self.lookupName = updated_product.lookupName

			self.createdTime = updated_product.createdTime

			self.updatedTime = updated_product.updatedTime

			self.name = updated_product.name

			self.parent = updated_product.parent

		end

		def self.check_self(obj,is_update = false)

			obj_attrs = ValidationsModule::extract_attributes(obj)

			obj_attrs = check_interfaces(obj_attrs)

			if is_update == true
			
				obj_attrs = remove_unused_new_attrs(obj_attrs)
			
			else

				obj_attrs = check_for_names(obj_attrs)

				obj_attrs = check_for_parents(obj_attrs)
				
			end

			obj_attrs

		end

		def self.check_for_names(obj_attrs)

			if obj_attrs[0]['names'].count == 0 || obj_attrs[0]['names'][0]['labelText'].nil? || obj_attrs[0]['names'][0]['language'].nil?
				
				raise ArgumentError, 'ServiceProduct should at least have one name set (new_service_product.names[0] = {"labelText" => "QTH45-test", "language" => {"id" => 1}} )'
			
			end

			obj_attrs

		end

		def self.check_for_parents(obj_attrs)

			if !obj_attrs[0]['parent'].nil? && obj_attrs[0]['parent'].is_a?(Hash) && !obj_attrs[0]['parent'].key?('id') && !obj_attrs[0]['parent'].key?('lookupName')
			
				obj_attrs[0].delete('parent')
			
			end

			obj_attrs

		end

		def self.remove_unused_new_attrs(obj_attrs)

			obj_attrs[0].delete('id')
			
			obj_attrs[0].delete('lookupName')
			
			obj_attrs[0].delete('createdTime')
			
			obj_attrs[0].delete('updatedTime')
			
			obj_attrs[0].delete('name')
			
			if !obj_attrs[0]['parent'].nil?
			
				obj_attrs[0].delete('parent')
			
			end

			obj_attrs

		end

		def self.check_interfaces(empty_arr)

			if empty_arr[0]['adminVisibleInterfaces'].empty?
				
				empty_arr[0].delete('adminVisibleInterfaces')
			
			end

			if empty_arr[0]['endUserVisibleInterfaces'].empty?
				
				empty_arr[0].delete('endUserVisibleInterfaces')
			
			end

			empty_arr

		end

	end

end