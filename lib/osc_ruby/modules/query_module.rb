require 'osc_ruby/connect'
require 'osc_ruby/modules/validations_module'
require 'osc_ruby/modules/normalize_module'
require_relative '../../ext/string.rb'

module OSCRuby

	module QueryModule

		class << self

			include ValidationsModule, NormalizeModule
		
			def find(rn_client,resource)

				obj_to_find = OSCRuby::Connect.get(rn_client,resource)

				if obj_to_find.code.to_i == 200 || obj_to_find.code.to_i == 201

					# ValidationsModule::check_obj_for_errors(obj_to_find)

					NormalizeModule::normalize(obj_to_find)
				else

					puts obj_to_find.body

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

		end
		
	end

end