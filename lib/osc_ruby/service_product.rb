require 'osc_ruby/client'
require 'osc_ruby/query_module'
require 'json'
require 'uri'

module OSCRuby
	
	class ServiceProduct

		include QueryModule
		
		attr_reader :id, :lookupName, :createdTime, :updatedTime, :name
		
		attr_accessor :names, :parent, :displayOrder, :adminVisibleInterfaces, :endUserVisibleInterfaces

	    def initialize(attributes = nil)

			if attributes.nil?

				@names = []

				@parent = {}

				@displayOrder = 1

				@adminVisibleInterfaces = []

				@endUserVisibleInterfaces = []

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

	    	final_json = self.class.check_self_for_create_method(new_product)

	    	resource = URI.escape("/serviceProducts")

	    	response = QueryModule::create(client,resource,final_json)

	    	if response.code == 200 && return_json == false

	    		prod_json = JSON.parse(response.body)

	    		final_prod = new_from_fetch(prod_json[0])

	    		puts "New product ${final_prod.name} was created"

	    		final_prod

	    	elsif return_json == true

	    		puts response.body

	    	end

	    end

	    def self.find(client,id = nil)

	    	check_client(client)

	    	if id.nil? == true
	    		raise ArgumentError, 'ID cannot be nil'
	    	elsif id.class != Fixnum
	    		raise ArgumentError, 'ID must be an integer'
	    	end
	    		
	    	resource = URI.escape("queryResults/?query=select * from serviceproducts where id = #{id}")

	    	service_product_json = QueryModule::find(client,resource)

	    	service_product_json_final = JSON.parse(service_product_json)

	      	new_from_fetch(service_product_json_final[0])

	    end

	    # def self.all(client)
	    	
	    # 	resource = URI.escape("queryResults/?query=select * from serviceproducts")

	    # 	service_product_json = QueryModule::find(client,resource)

	    # 	service_product_json_final = JSON.parse(service_product_json)

	    # 	service_product_json_final.map { |attributes| new_from_fetch(attributes) }

	    # end

		def self.new_from_fetch(attributes)

	    	check_attributes(attributes)

	    	OSCRuby::ServiceProduct.new(attributes)

		end

		def self.check_self_for_create_method(obj)

			empty_arr = []

	    	json_content = {}

			obj.instance_variables.each {|var| json_content[var.to_s.delete("@")] = obj.instance_variable_get(var)}
			
			empty_arr[0] = json_content

			if empty_arr[0]['names'].count == 0 || empty_arr[0]['names'][0]['labelText'].nil? || empty_arr[0]['names'][0]['language'].nil?
				raise ArgumentError, 'ServiceProduct should at least have one name set (new_service_product.names[0] = {"labelText" => "QTH45-test", "language" => {"id" => 1}} )'
			end

			if empty_arr[0]['adminVisibleInterfaces'].empty?
				empty_arr[0].delete('adminVisibleInterfaces')
			end

			if empty_arr[0]['endUserVisibleInterfaces'].empty?
				empty_arr[0].delete('endUserVisibleInterfaces')
			end

			if !empty_arr[0]['parent'].key?('id') && !empty_arr[0]['parent'].key?('name')
				empty_arr[0].delete('parent')
			end

			empty_arr

		end

		def self.check_attributes(attributes)

			if attributes.class != Hash
				
				raise ArgumentError, "Attributes must be a hash; please use the appropriate data structure"
		
			end

		end

		def self.check_client(client)

			if client.class != OSCRuby::Client || client.nil?
				raise ArgumentError, "Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings"
			end

		end

	end

end