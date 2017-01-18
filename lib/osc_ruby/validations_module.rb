require 'osc_ruby/connect'
require 'json'

module OSCRuby

	module ValidationsModule

		class << self

			def extract_attributes(obj)

				empty_arr = [{}]

				obj_vars = obj.instance_variables

				obj_vars.each do |var| 

					obj_attr = var.to_s.delete("@")

					obj_attr_val = obj.instance_variable_get(var)

					empty_arr[0][obj_attr] = obj_attr_val

				end

				empty_arr

			end

			def check_for_id(id)

				if id.nil? == true

		    		raise ArgumentError, 'ID cannot be nil'

				elsif id.class != Fixnum

		    		raise ArgumentError, 'ID must be an integer'

				end

			end

			def check_object_for_id(obj,class_name)

				if obj.id.nil?

					raise ArgumentError, "#{class_name} must have a valid ID set"

				end

			end

			def check_attributes(attributes)

				if attributes.class != Hash
					
					raise ArgumentError, "Attributes must be a hash; please use the appropriate data structure"
			
				end

			end

		    def check_query(query)

				if query.empty?
					
					raise ArgumentError, 'A query must be specified when using the "where" method'

				end

		    end

		    def check_attributes_request(attributes_request,class_name)

				if attributes_request.empty?
					
					raise ArgumentError, "The attributes you are requesting for the #{class_name} object must be specified when using the 'select' method"

				end

		    end

			def check_client(client)

				if client.class != OSCRuby::Client || client.nil?

					raise ArgumentError, "Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings"

				end

			end

			def attr_hash_exists_and_is_type_of(obj,key,val,class_of_value)

				return obj[0][key][val].nil? || obj[0][key][val].class != class_of_value

			end

			def check_for_names(obj_attrs,class_name)

				if obj_attrs[0]['names'].count == 0 || obj_attrs[0]['names'][0]['labelText'].nil? || obj_attrs[0]['names'][0]['language'].nil?
					
					raise ArgumentError, "#{class_name} should at least have one name set"
				
				end

				obj_attrs

			end

			def check_for_parents(obj_attrs)

				if !obj_attrs[0]['parent'].nil? && obj_attrs[0]['parent'].is_a?(Hash) && !obj_attrs[0]['parent'].key?('id') && !obj_attrs[0]['parent'].key?('lookupName')
				
					obj_attrs[0].delete('parent')
				
				end

				obj_attrs

			end

			def check_interfaces(empty_arr)

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
	
end