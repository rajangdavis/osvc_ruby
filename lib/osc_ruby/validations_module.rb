require 'osc_ruby/connect'
require 'json'

module OSCRuby

	module ValidationsModule

		def self.extract_attributes(obj)

			empty_arr = [{}]

			obj_vars = obj.instance_variables

			obj_vars.each do |var| 

				obj_attr = var.to_s.delete("@")

				obj_attr_val = obj.instance_variable_get(var)

				empty_arr[0][obj_attr] = obj_attr_val

			end

			empty_arr

		end

	end
	
end