require_relative 'query_results'
require 'osc_ruby/modules/validations_module'
require 'ostruct'

module OSCRuby

	class QueryResultsSet

		include ValidationsModule

		def query_set(client,*args)

			ValidationsModule::check_client(client)
			
			query_arr = []
			
			key_map = []

			args.each do |qh|

				key_map.push(qh[:key])

				query_arr.push(qh[:query])	
			
			end

			query_results_set = OpenStruct.new
			query_search = OSCRuby::QueryResults.new
		

			final_query_arr = query_arr.join('; ')
			final_results = query_search.query(client,final_query_arr)

			key_map.each_with_index {|k,i| query_results_set[k] = final_results[i]}
			query_results_set
		end

	end 

end