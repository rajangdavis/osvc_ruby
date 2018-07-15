require_relative 'query_results'
require 'osvc_ruby/modules/validations_module'

module OSvCRuby

	class QueryResultsSet

		include ValidationsModule

		def query_set(client,*args)
			
			query_arr = []
			
			key_map = []

			args.each do |qh|

				key_map.push(qh[:key].to_sym)

				query_arr.push(qh[:query])	
			
			end

			query_results_set = Struct.new( *key_map )
			query_search = OSvCRuby::QueryResults.new
		

			final_query_arr = query_arr.join('; ')
			final_results = query_search.query(client,final_query_arr)

			final_query_results_set = query_results_set.new( *final_results )
			final_query_results_set
		end

	end 

end