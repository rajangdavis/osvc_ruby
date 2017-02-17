require 'json'

module OSCRuby

	module NormalizeModule

		class << self

			def normalize(input,resource)

				if input.code.to_i == 404

					input.body

				else

					json_input = JSON.parse(input.body)

					final_hash = []

					json_input['items'].each do |item|

						item['rows'].each_with_index do |row,row_i|

							obj_hash = {}
							
							item['columnNames'].each_with_index do |column,i|
								obj_hash[column] = if !row[i].nil? && row[i].is_i? == true then row[i].to_i else row[i] end
							end

							final_hash.push(obj_hash)

							if json_input['items'].count > 1 && (item['rows'].count-1 <= row_i)

								final_hash.push("\n")

							end

						end

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

					puts JSON.pretty_generate(final_hash)
					
					final_hash.to_json

				end

			end

			def query_injection(query,json_response)

				queries = query.split(';')

				count = 0

				json_response.each_with_index do |hash,i|
					if hash == "\n" && queries.count > 1
						json_response[i] = "\nResults for #{queries[count]}:"
						count += 1
					elsif hash == "\n"
						json_response.delete_at(i)
					elsif json_response.last == "\n" 
						json_response.delete_at(json_response.count - 1)
					end
				end

				json_response

			end

			def remove_new_lines(json_response)
				json_response.each_with_index do |hash,i|
					if hash == "\n"
						json_response.delete_at(i)
					end
				end

				json_response
			end

		end
	end
end