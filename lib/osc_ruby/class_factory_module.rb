require 'osc_ruby/connect'
require 'osc_ruby/validations_module'
require 'json'

module OSCRuby

	module ClassFactoryModule

		class << self

			def new_from_fetch(attributes,class_name)

		    	ValidationsModule.check_attributes(attributes)

		    	class_name.new(attributes)

			end

			def find(client,id,obj_query,return_json,class_name)

		    	ValidationsModule::check_client(client)

		    	ValidationsModule::check_for_id(id)

		    	url = "queryResults/?query=select * from #{obj_query} where id = #{id}"
		    		
		    	resource = URI.escape(url)

		    	class_json = QueryModule::find(client,resource)

				if return_json == true

					class_json

				else

					class_json_final = JSON.parse(class_json)

					ClassFactoryModule::new_from_fetch(class_json_final[0],class_name)

				end

			end

			def all(client,obj_query,return_json,class_name)

				ValidationsModule::check_client(client)
	    	
				resource = URI.escape("queryResults/?query=select * from #{obj_query}")

				service_product_json = QueryModule::find(client,resource)

				if return_json == true

					service_product_json

				else

					service_product_json_final = JSON.parse(service_product_json)

					service_product_json_final.map { |attributes| ClassFactoryModule::new_from_fetch(attributes,OSCRuby::ServiceProduct) }

			    end

			end

			def create(client,obj,resource_uri,return_json,class_name)

				ValidationsModule::check_client(client)

		    	final_json = obj.class.check_self(obj)

		    	resource = URI.escape(resource_uri)

		    	response = QueryModule::create(client,resource,final_json)

		    	response_body = JSON.parse(response.body)

		    	if response.code.to_i == 201 && return_json == false

					obj.set_attributes(response_body)

		    	elsif return_json == true

		    		response.body

		    	end

			end

			def where(client,query,object_in_query,return_json,class_name)

				ValidationsModule::check_client(client)

				ValidationsModule::check_query(query)

		    	@query = URI.escape("queryResults/?query=select * from #{object_in_query} where #{query}")

		    	service_product_json = QueryModule::find(client,@query)

		    	if return_json == true

		    		service_product_json

		    	else

			    	service_product_json_final = JSON.parse(service_product_json)

			    	service_product_json_final.map { |attributes| ClassFactoryModule::new_from_fetch(attributes,class_name) }

			    end

		    end

		    def destroy(client,obj,resource_uri,return_json)

		    	ValidationsModule::check_client(client)

		    	obj.class.check_for_id(obj)

		    	resource = URI.escape("/#{resource_uri}/#{obj.id}")

		    	response = QueryModule::destroy(client,resource)

		    	if response.code.to_i == 200 && return_json == false

		    		nil

		    	elsif return_json == true

		    		response.body

		    	end

		    end

		end

	end
	
end