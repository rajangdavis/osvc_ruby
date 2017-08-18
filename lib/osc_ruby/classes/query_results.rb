require 'osc_ruby/modules/validations_module'
require 'osc_ruby/modules/normalize_module'
require 'osc_ruby/modules/query_module'
require 'json'

module OSCRuby

	class QueryResults

		include QueryModule
		include ValidationsModule

		def initialize; end

		def query(client,query)

			ValidationsModule::check_client(client)

			ValidationsModule::check_query(query,"query")

			@query = URI.escape("queryResults/?query=#{query}")

	    	response = QueryModule::find(client,@query)

	    	JSON.parse(response) 
 			
		end


	
	end

end