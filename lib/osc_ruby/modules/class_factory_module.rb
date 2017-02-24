require 'osc_ruby/connect'
require 'osc_ruby/modules/validations_module'
require 'json'

module OSCRuby

	module ClassFactoryModule

		class << self

			def new_from_fetch(attributes,class_name,custom_or_nested = nil)

		    	ValidationsModule.check_attributes(attributes)

		    	class_name.new(attributes)

			end

			def create(client,obj,resource_uri,return_json)

				ValidationsModule::check_client(client)

		    	final_json = obj.class.check_self(obj)

		    	resource = URI.escape(resource_uri)

		    	response = QueryModule::create(client,resource,final_json)

		    	response_body = JSON.parse(response.body)

		    	if response.code.to_i == 201 && return_json == false

		    		if obj.class.respond_to? :set_attributes
						obj.class.new(response_body)
					else
						obj.set_attributes(response_body)
					end

		    	elsif return_json == true

		    		response.body

		    	end

			end

			def find(client,id,obj_query,return_json,class_name,custom_or_nested = nil)

		    	ValidationsModule::check_client(client)

		    	ValidationsModule::check_for_id(id)

		    	url = "queryResults/?query=select * from #{obj_query} where id = #{id}"
		    		
		    	resource = URI.escape(url)

		    	class_json = QueryModule::find(client,resource)

				if return_json == true

					class_json

				else

					class_json_final = JSON.parse(class_json)

					ClassFactoryModule::new_from_fetch(class_json_final[0],class_name,custom_or_nested = nil)

				end

			end

			def all(client,obj_query,return_json,class_name,custom_or_nested = nil)

				ValidationsModule::check_client(client)
	    	
				resource = URI.escape("queryResults/?query=select * from #{obj_query}")

				object_json = QueryModule::find(client,resource)

				ClassFactoryModule::instantiate_multiple_objects(return_json, object_json, class_name,custom_or_nested = nil)

			end

			def where(client,query,object_in_query,return_json,class_name,custom_or_nested = nil)

				ValidationsModule::check_client(client)

				ValidationsModule::check_query(query,'where')

				@query = URI.escape("queryResults/?query=select * from #{object_in_query} where #{query}")

		    	object_json = QueryModule::find(client,@query)

		    	ClassFactoryModule::instantiate_multiple_objects(return_json, object_json, class_name,custom_or_nested = nil)

			end

		    def update(client,obj,resource_uri,return_json)

				ValidationsModule::check_client(client)

		    	ValidationsModule::check_object_for_id(obj,obj.class)

		    	final_json = obj.class.check_self(obj,true)

		    	resource = URI.escape("#{resource_uri}/#{obj.id}")

		    	response = QueryModule::update(client,resource,final_json)

		    	if response.code.to_i == 200 && return_json == false

		    		updated_obj = obj.class.find(client,obj.id)

		    		obj.update_attributes(updated_obj)

		    	elsif return_json == true

		    		response.body

		    	end

		    end

		    def destroy(client,obj,resource_uri,return_json)

		    	ValidationsModule::check_client(client)

		    	ValidationsModule::check_object_for_id(obj,obj.class)

		    	resource = URI.escape("/#{resource_uri}/#{obj.id}")

		    	response = QueryModule::destroy(client,resource)

		    	if response.code.to_i == 200 && return_json == false

		    		nil

		    	elsif return_json == true

		    		response.body

		    	end

		    end

		    def instantiate_multiple_objects(return_json, object_json, class_name,custom_or_nested = nil)

		    	if return_json == true

		    		object_json

		    	else

			    	object_json_final = JSON.parse(object_json)

			    	object_json_final.map { |attributes| ClassFactoryModule::new_from_fetch(attributes,class_name,custom_or_nested = nil) }

			    end

		    end

		end

	end
	
end