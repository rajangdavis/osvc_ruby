require 'osc_ruby/client'
require 'osc_ruby/query_module'
require 'json'
require 'uri'

module OSCRuby
	
	class Answer

		include QueryModule
		
		attr_accessor :answerType, :language, :summary

	    def initialize(attributes = nil)

   			@answerType = {}

   			@language = {}

   			@summary = "Answer summary text"

			# if attributes.nil?

			# 	@parent = {}

			# 	@displayOrder = 1

			# else

			# 	@id = attributes["id"]
		      
			# 	@lookupName = attributes["lookupName"]
		      
			# 	@createdTime = attributes["createdTime"]
		      
			# 	@updatedTime = attributes["updatedTime"]
		      
			# 	@displayOrder = attributes["displayOrder"]
		      
			# 	@name = attributes["name"]
		      
			# 	@parent = attributes["parent"]

			# end

	    end

# 	    def create(client,return_json = false)

# 	    	self.class.check_client(client)

# 	    	new_product = self

# 	    	final_json = self.class.check_self(new_product)

# 	    	resource = URI.escape("/Answers")

# 	    	response = QueryModule::create(client,resource,final_json)

# 	    	response_body = JSON.parse(response.body)

# 	    	if response.code.to_i == 201 && return_json == false

# 	    		self.id = response_body['id'].to_i

# 	    		self.name = response_body["lookupName"]

# 	    		self.lookupName = response_body["lookupName"]

# 				self.displayOrder = response_body["displayOrder"]

# 				if !response_body["parent"].nil?

# 					self.parent = response_body["parent"]["links"][0]["href"].split('/').pop.to_i

# 				else

# 					self.parent = nil

# 				end

# 	    	elsif return_json == true

# 	    		response.body

# 	    	end

# 	    end

# 	    def self.find(client,id = nil,return_json = false)

# 	    	check_client(client)

# 	    	if id.nil? == true
# 	    		raise ArgumentError, 'ID cannot be nil'
# 	    	elsif id.class != Fixnum
# 	    		raise ArgumentError, 'ID must be an integer'
# 	    	end
	    		
# 	    	resource = URI.escape("queryResults/?query=select * from Answers where id = #{id}")

# 	    	service_product_json = QueryModule::find(client,resource)

# 			if return_json == true

# 				service_product_json

# 			else

# 				service_product_json_final = JSON.parse(service_product_json)

# 				new_from_fetch(service_product_json_final[0])

# 			end

# 	    end

# 	    def self.all(client, return_json = false)

# 	    	check_client(client)
	    	
# 	    	resource = URI.escape("queryResults/?query=select * from Answers")

# 	    	service_product_json = QueryModule::find(client,resource)

# 	    	if return_json == true

# 	    		service_product_json

# 	    	else

# 		    	service_product_json_final = JSON.parse(service_product_json)

# 		    	service_product_json_final.map { |attributes| new_from_fetch(attributes) }

# 		    end

# 	    end

# 	    def self.where(client, query = '', return_json = false)

# 	    	check_client(client)

# 	    	check_query(query)

# 	    	@query = URI.escape("queryResults/?query=select * from Answers where #{query}")

# 	    	service_product_json = QueryModule::find(client,@query)

# 	    	if return_json == true

# 	    		service_product_json

# 	    	else

# 		    	service_product_json_final = JSON.parse(service_product_json)

# 		    	service_product_json_final.map { |attributes| new_from_fetch(attributes) }

# 		    end

# 	    end

# 	    def update(client, return_json = false)

# 	    	self.class.check_client(client)

# 	    	product_to_update = self

# 	    	self.class.check_for_id(product_to_update)

# 	    	final_json = self.class.check_self(product_to_update,true)

# 	    	resource = URI.escape("/Answers/#{product_to_update.id}")

# 	    	response = QueryModule::update(client,resource,final_json)

# 	    	if response.code.to_i == 200 && return_json == false

# 	    		updated_product = OSCRuby::Answer.find(client,product_to_update.id)

# 	    		self.lookupName = updated_product.lookupName

# 				self.createdTime = updated_product.createdTime

# 				self.updatedTime = updated_product.updatedTime

# 				self.name = updated_product.name

# 				self.parent = updated_product.parent

# 	    	elsif return_json == true

# 	    		response.body

# 	    	end

# 	    end

# 	    def destroy(client, return_json = false)

# 	    	self.class.check_client(client)

# 	    	product_to_destroy = self

# 	    	self.class.check_for_id(product_to_destroy)

# 	    	resource = URI.escape("/Answers/#{product_to_destroy.id}")

# 	    	response = QueryModule::destroy(client,resource)

# 	    	if response.code.to_i == 200 && return_json == false

# 	    		nil

# 	    	elsif return_json == true

# 	    		response.body

# 	    	end

# 	    end











# 	    # Convenience Methods for making the CRUD operations nicer to use

# 		def self.new_from_fetch(attributes)

# 	    	check_attributes(attributes)

# 	    	OSCRuby::Answer.new(attributes)

# 		end

# 		def self.check_for_id(obj)

# 			if obj.id.nil?

# 				raise ArgumentError, 'OSCRuby::Answer must have a valid ID set'

# 			end

# 		end

# 		def self.check_self(obj,is_update = false)

# 			obj_attrs = self.extract_attributes(obj)

# 			if is_update == true
			
# 				obj_attrs = remove_unused_new_attrs(obj_attrs)
			
# 			else

# 				obj_attrs = check_for_names(obj_attrs)

# 				obj_attrs = check_for_parents(obj_attrs)
				
# 			end

# 			obj_attrs

# 		end

# 		def self.check_for_names(obj_attrs)

# 			if obj_attrs[0]['names'].count == 0 || obj_attrs[0]['names'][0]['labelText'].nil? || obj_attrs[0]['names'][0]['language'].nil?
				
# 				raise ArgumentError, 'Answer should at least have one name set (new_service_product.names[0] = {"labelText" => "QTH45-test", "language" => {"id" => 1}} )'
			
# 			end

# 			obj_attrs

# 		end

# 		def self.check_for_parents(obj_attrs)

# 			if !obj_attrs[0]['parent'].nil? && obj_attrs[0]['parent'].is_a?(Hash) && !obj_attrs[0]['parent'].key?('id') && !obj_attrs[0]['parent'].key?('lookupName')
			
# 				obj_attrs[0].delete('parent')
			
# 			end

# 			obj_attrs

# 		end

# 		def self.remove_unused_new_attrs(obj_attrs)

# 			obj_attrs[0].delete('id')
			
# 			obj_attrs[0].delete('lookupName')
			
# 			obj_attrs[0].delete('createdTime')
			
# 			obj_attrs[0].delete('updatedTime')
			
# 			obj_attrs[0].delete('name')
			
# 			if !obj_attrs[0]['parent'].nil?
			
# 				obj_attrs[0].delete('parent')
			
# 			end

# 			obj_attrs

# 		end

# 		def self.extract_attributes(obj)

# 			empty_arr = [{}]

# 			obj_vars = obj.instance_variables

# 			obj_vars.each do |var| 

# 				obj_attr = var.to_s.delete("@")

# 				obj_attr_val = obj.instance_variable_get(var)

# 				empty_arr[0][obj_attr] = obj_attr_val

# 			end

# 			if empty_arr[0]['adminVisibleInterfaces'].empty?
				
# 				empty_arr[0].delete('adminVisibleInterfaces')
			
# 			end

# 			if empty_arr[0]['endUserVisibleInterfaces'].empty?
				
# 				empty_arr[0].delete('endUserVisibleInterfaces')
			
# 			end

# 			empty_arr

# 		end



# 		# Will probably extract the following into a Validations class or something

# 		def self.check_attributes(attributes)

# 			if attributes.class != Hash
				
# 				raise ArgumentError, "Attributes must be a hash; please use the appropriate data structure"
		
# 			end

# 		end

# 	    def self.check_query(query)

# 			if query.empty?
				
# 				raise ArgumentError, 'A query must be specified when using the "where" method'

# 			end

# 	    end

# 		def self.check_client(client)

# 			if client.class != OSCRuby::Client || client.nil?
# 				raise ArgumentError, "Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings"
# 			end

# 		end

	end

end