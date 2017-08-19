require 'json'

module OSCRuby

	module NormalizeModule

		class << self

			def normalize(input)

				if input.code.to_i == 404

					input.body

				else

					json_input = JSON.parse(input.body)

					final_hash = []

					json_input['items'].each do |item|
						results_array = iterate_through_rows(item)							
				        final_hash.push(results_array)
					end

					if final_hash.size === 1
						final_hash = final_hash.flatten!
					end

					final_hash.to_json

				end

			end

			def iterate_through_rows(item)

				results_array = []

		        item['rows'].each_with_index do |row,_row_i|

	                obj_hash = {}
	                
	                item['columnNames'].each_with_index do |column,i|

                        obj_hash[column] = if !row[i].nil? && row[i].is_i? == true then row[i].to_i else row[i] end

	                end

	    			results_array.push(obj_hash)

		        end

		        results_array

			end

		end

	end
	
end