require 'osc_ruby/modules/validations_module'
require 'osc_ruby/modules/normalize_module'
require_relative '../../ext/string.rb'
require 'json'

module OSCRuby

	class QueryResults

		include ValidationsModule, NormalizeModule

		def initialize; end

		def query(client,query)

			ValidationsModule::check_client(client)

			ValidationsModule::check_query(query,"query")

			@query = URI.escape("queryResults/?query=#{query}")
	    	
	    	obj_to_find = OSCRuby::Connect.get(client,@query)

			if obj_to_find.code.to_i == 200 || obj_to_find.code.to_i == 201

				response = NormalizeModule::normalize(obj_to_find)
			else

				response = obj_to_find.body

			end

	    	JSON.parse(response) 
 			
		end


	
	end

end