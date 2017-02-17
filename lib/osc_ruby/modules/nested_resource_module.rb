module OSCRuby
	module NestedResourceModule
		class << self
			def get_resource(rn_client,originator,resource)
				puts "#{originator.class} has an id of #{originator.id}"
				resource.where(rn_client,"id < 100")
			end
		end
	end
end