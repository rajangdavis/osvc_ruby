require 'osc_ruby/connect'
require 'osc_ruby/validations_module'
require 'json'

module OSCRuby

	class QueryResults

		include QueryModule
		include ValidationsModule

		def initialize; end

		def select(client,query)

			ValidationsModule::check_client(client)

			ValidationsModule::check_query(query,"select")

			@query = URI.escape("queryResults/?query=#{query}")

	    	response = QueryModule::find(client,@query)

	    	json_response = JSON.parse(response) 

	    	puts "Results for '#{query}'"
	    	puts
	    	puts json_response
	    	puts
	 
		end
	
	end

end