require 'osc_ruby/client'
require 'osc_ruby/query_module'
require 'json'
require 'uri'

module OSCRuby
	
	class ServiceProduct

		include QueryModule
		
		attr_accessor :names, :parent, :displayOrder, :adminVisibleInterfaces, :endUserVisibleInterfaces, :id, :lookupName, :createdTime, :updatedTime, :name

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

	    	self.class.check_client(client)

	    	new_product = self

	    	final_json = self.class.check_self(new_product)

	    	resource = URI.escape("/serviceProducts")

	    	response = QueryModule::create(client,resource,final_json)

	    	response_body = JSON.parse(response.body)

	    	if response.code.to_i == 201 && return_json == false

	    		self.id = response_body['id'].to_i

	    		self.name = response_body["lookupName"]

	    		self.lookupName = response_body["lookupName"]

				self.displayOrder = response_body["displayOrder"]

				if !response_body["parent"].nil?

					self.parent = response_body["parent"]["links"][0]["href"].split('/').pop.to_i

				else

					self.parent = nil

				end

	    	elsif return_json == true

	    		response.body

	    	end

	    end

	    def self.find(client,id = nil,return_json = false)

	    	check_client(client)

	    	if id.nil? == true
	    		raise ArgumentError, 'ID cannot be nil'
	    	elsif id.class != Fixnum
	    		raise ArgumentError, 'ID must be an integer'
	    	end
	    		
	    	resource = URI.escape("queryResults/?query=select * from serviceproducts where id = #{id}")

	    	service_product_json = QueryModule::find(client,resource)

			if return_json == true

				service_product_json

			else

				service_product_json_final = JSON.parse(service_product_json)

				new_from_fetch(service_product_json_final[0])

			end

	    end

	    def self.all(client, return_json = false)

	    	check_client(client)
	    	
	    	resource = URI.escape("queryResults/?query=select * from serviceproducts")

	    	service_product_json = QueryModule::find(client,resource)

	    	if return_json == true

	    		service_product_json

	    	else

		    	service_product_json_final = JSON.parse(service_product_json)

		    	service_product_json_final.map { |attributes| new_from_fetch(attributes) }

		    end

	    end

	    def self.where(client, query = '', return_json = false)

	    	check_client(client)

	    	check_query(query)

	    	@query = URI.escape("queryResults/?query=select * from serviceproducts where #{query}")

	    	service_product_json = QueryModule::find(client,@query)

	    	if return_json == true

	    		service_product_json

	    	else

		    	service_product_json_final = JSON.parse(service_product_json)

		    	service_product_json_final.map { |attributes| new_from_fetch(attributes) }

		    end

	    end

	    def update(client, return_json = false)

	    	self.class.check_client(client)

	    	product_to_update = self

	    	final_json = self.class.check_self(product_to_update,true)

	    	resource = URI.escape("/serviceProducts/#{product_to_update.id}")

	    	response = QueryModule::update(client,resource,final_json)

	    	if response.code.to_i == 200 && return_json == false

	    		updated_product = OSCRuby::ServiceProduct.find(client,product_to_update.id)

	    		self.lookupName = updated_product.lookupName

				self.createdTime = updated_product.createdTime

				self.updatedTime = updated_product.updatedTime

				self.name = updated_product.name

				self.parent = updated_product.parent

	    	elsif return_json == true

	    		response.body

	    	end

	    end

	    # Convenience Methods for making the CRUD operations nicer to use

		def self.new_from_fetch(attributes)

	    	check_attributes(attributes)

	    	OSCRuby::ServiceProduct.new(attributes)

		end

	    
		def self.check_self(obj,is_update = false)

			empty_arr = [{}]

			obj_vars = obj.instance_variables

			obj_vars.each do |var| 

				obj_attr = var.to_s.delete("@")

				obj_attr_val = obj.instance_variable_get(var)

				empty_arr[0][obj_attr] = obj_attr_val

			end

			if is_update == true
				empty_arr[0].delete('id')
				empty_arr[0].delete('lookupName')
				empty_arr[0].delete('createdTime')
				empty_arr[0].delete('updatedTime')
				empty_arr[0].delete('name')
			end

			if is_update == false && (empty_arr[0]['names'].count == 0 || empty_arr[0]['names'][0]['labelText'].nil? || empty_arr[0]['names'][0]['language'].nil?)
				raise ArgumentError, 'ServiceProduct should at least have one name set (new_service_product.names[0] = {"labelText" => "QTH45-test", "language" => {"id" => 1}} )'
			end

			if empty_arr[0]['adminVisibleInterfaces'].empty?
				empty_arr[0].delete('adminVisibleInterfaces')
			end

			if empty_arr[0]['endUserVisibleInterfaces'].empty?
				empty_arr[0].delete('endUserVisibleInterfaces')
			end

			if !empty_arr[0]['parent'].nil? && empty_arr[0]['parent'].is_a?(Hash) && !empty_arr[0]['parent'].key?('id') && !empty_arr[0]['parent'].key?('lookupName')
				empty_arr[0].delete('parent')
			elsif is_update == true && !empty_arr[0]['parent'].nil?
				empty_arr[0].delete('parent')
			end

			empty_arr

		end

		def self.check_attributes(attributes)

			if attributes.class != Hash
				
				raise ArgumentError, "Attributes must be a hash; please use the appropriate data structure"
		
			end

		end

	    def self.check_query(query)

			if query.empty?
				
				raise ArgumentError, 'A query must be specified when using the "where" method'

			end

	    end

		def self.check_client(client)

			if client.class != OSCRuby::Client || client.nil?
				raise ArgumentError, "Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings"
			end

		end

	end

end