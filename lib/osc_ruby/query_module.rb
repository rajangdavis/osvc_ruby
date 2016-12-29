require 'osc_ruby/connect'
require_relative '../ext/string'

require 'json'

module OSCRuby

	module QueryModule
	
		def self.find(rn_client,resource)

			obj_to_find = OSCRuby::Connect.get(rn_client,resource)

			check_obj_for_errors(obj_to_find)

			obj_info = normalize(obj_to_find)

		end

		def self.create(rn_client,resource,json_content)

			obj_to_find = OSCRuby::Connect.post_or_patch(rn_client,resource,json_content)

			obj_to_find.body

		end

		def self.normalize(input)

			if input.code.to_i == 404

				input.body

			else

				_json = JSON.parse(input.body)

				final_hash = []

				_json['items'][0]['rows'].each do |row|

					obj_hash = {}
					
					_json['items'][0]['columnNames'].each_with_index do |column,i|
						obj_hash[column] = if !row[i].nil? && row[i].is_i? == true then row[i].to_i else row[i] end
					end

					final_hash.push(obj_hash)

				end

				final_hash.to_json

			end

		end

		def self.check_obj_for_errors(obj_to_check)

			_json = JSON.parse(obj_to_check.body)

			if _json['items'][0]['rows'].count == 0

				raise ArgumentError, 'There were no objects matching your query; please try again.'

			end

		end
		
	end

end