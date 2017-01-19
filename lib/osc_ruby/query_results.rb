require 'osc_ruby/connect'
require 'osc_ruby/validations_module'
require 'json'

module OSCRuby

	class QueryResults

		include QueryModule
		include ValidationsModule

		def initialize; end

		def select(client,query,return_json = false)

			ValidationsModule::check_client(client)

			ValidationsModule::check_query(query,"select")

			@query = URI.escape("queryResults/?query=select #{query}")

	    	response = QueryModule::find(client,@query)

	    	response_body = JSON.parse(response.body)

	    	if response.code.to_i == 201 && return_json == false

				response_body

	    	elsif return_json == true

	    		response.body

	    	end
	 
		end
	
	end

end