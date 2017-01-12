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

			def check_client(client)

				if client.class != OSCRuby::Client || client.nil?

					raise ArgumentError, "Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings"

				end

			end

		end

	end
	
end