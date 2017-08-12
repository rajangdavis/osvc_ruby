require 'json'

module OSCRuby

	module NormalizeModule

		class << self

			def normalize(input,resource)

				if input.code.to_i == 404

					input.body

				else

					json_input = JSON.parse(input.body)

					# initialize an array to hold all of the objects
					final_hash = []

					# loop through the items from the returned JSON response
					json_input['items'].each do |item|

							results_array = []

					        # loop through rows
					        item['rows'].each_with_index do |row,row_i|

					                # initialize a hash to create the object
					                obj_hash = {}
					                
					                # loop through the column names from the query
					                item['columnNames'].each_with_index do |column,i|

					                        # set the object property to the value of the row
					                        # where the index of the value within that row
					                        # matches the index of the column name
					                        obj_hash[column] = if !row[i].nil? && row[i].is_i? == true then row[i].to_i else row[i] end
					                end

					    			# push the hash into the array
					    			results_array.push(obj_hash)

					        end

			    			# puts "this is an array:  #{final_hash}"
					        final_hash.push(results_array)


					end

					if final_hash.size === 1
						final_hash = final_hash.flatten!
					end


					final_hash.to_json

				end

			end

			def nested_normalize(input,resource)

				if input.code.to_i == 404

					input.body

				else

					json_input = JSON.parse(input.body)
					
					final_hash = []

					json_input['items'].each do |item|

						item_array = []

						item['rows'].each_with_index do |row,row_i|

							obj_hash = {}
							
							item['columnNames'].each_with_index do |column,i|
								obj_hash[column] = if !row[i].nil? && row[i].is_i? == true then row[i].to_i else row[i] end
							end

							item_array.push(obj_hash)

						end

						final_hash.push(item_array)

					end

					
					final_hash.to_json

				end

			end

		end

	end
	
end