require 'osc_ruby/connect'
require 'osc_ruby/validations_module'
require_relative '../ext/string'

require 'json'

module OSCRuby

	module QueryModule

		class << self

			include ValidationsModule
		
			def find(rn_client,resource)

				obj_to_find = OSCRuby::Connect.get(rn_client,resource)

				if obj_to_find.code.to_i == 200 || obj_to_find.code.to_i == 201

					check_obj_for_errors(obj_to_find)

					normalize(obj_to_find,resource)
				else

					obj_to_find.body

				end

			end

			def create(rn_client,resource,json_content)

				OSCRuby::Connect.post_or_patch(rn_client,resource,json_content)

			end

			def update(rn_client,resource,json_content)

				OSCRuby::Connect.post_or_patch(rn_client,resource,json_content,true)

			end

			def destroy(rn_client,resource)

				OSCRuby::Connect.delete(rn_client,resource)
				
			end

			def normalize(input,resource)

				if input.code.to_i == 404

					input.body

				else

					json_input = JSON.parse(input.body)

					final_hash = []

					query_capture = URI.unescape(resource).split('=')[1]

					queries = query_capture.split(';')

					json_input['items'].each do |item|

						item['rows'].each_with_index do |row,row_i|

							obj_hash = {}
							
							item['columnNames'].each_with_index do |column,i|
								obj_hash[column] = if !row[i].nil? && row[i].is_i? == true then row[i].to_i else row[i] end
							end

							final_hash.push(obj_hash)

							if json_input['items'].count > 1 && (item['rows'].count-1 == row_i)

								final_hash.push("\n")

							end

						end

					end

					final_hash.to_json

				end

			end

			def check_obj_for_errors(obj_to_check)

				json_obj = JSON.parse(obj_to_check.body)

				if !json_obj.nil? && json_obj['items'][0]['rows'].count == 0

					raise ArgumentError, 'There were no objects matching your query; please try again.'

				end

			end

		end
		
	end

end