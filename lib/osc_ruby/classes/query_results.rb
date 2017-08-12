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

	    	json_response
 			
		end
	
	end

end