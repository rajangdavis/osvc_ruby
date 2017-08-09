require 'osc_ruby/connect'
require 'osc_ruby/modules/validations_module'
require 'osc_ruby/modules/normalize_module'
require 'osc_ruby/modules/query_module'
require 'json'

module OSCRuby

	class QueryResults

		include QueryModule
		include ValidationsModule

		def initialize; end

		def query(client,query,return_json = false)

			ValidationsModule::check_client(client)

			ValidationsModule::check_query(query,"query")

			@query = URI.escape("queryResults/?query=#{query}")

	    	response = QueryModule::find(client,@query)

	    	json_response = JSON.parse(response) 

	    	if return_json == true
	    		json_response_final = NormalizeModule::query_injection(query,json_response)
	    		puts json_response_final
	    	end

	    	if return_json.class == Hash
	    		puts json_response.body
	    	else
		    	json_response.unshift("\n")
		    	NormalizeModule::remove_new_lines(json_response)
 			end
 			
		end
	
	end

end