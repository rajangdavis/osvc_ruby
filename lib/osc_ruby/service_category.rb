module OSCRuby

	class ServiceCategory < ServiceClass

		attr_accessor :names,:parent,:displayOrder,:adminVisibleInterfaces,:endUserVisibleInterfaces,:id,:lookupName,:createdTime,:updatedTime,:name

	    def initialize(attributes = nil)

    		@names = []
			@adminVisibleInterfaces = []
			@endUserVisibleInterfaces = []

			if attributes.nil?

				@parent = {}
				@displayOrder = 1

			else

				@id = attributes["id"]
				@lookupName = attributes["lookupName"]
				@createdTime = attributes["createdTime"]
				@updatedTime = attributes["updatedTime"]
				@displayOrder = attributes["displayOrder"]
				@name = attributes["name"]
				@parent = attributes["parent"]

			end

	    end

	    # Convenience Methods for making the CRUD operations nicer to use

		def set_attributes(response_body)

			self.id = response_body["id"]

    		self.name = response_body["lookupName"]

    		self.lookupName = response_body["lookupName"]

			self.displayOrder = response_body["displayOrder"]

			if !response_body["parent"].nil?

				self.parent = response_body["parent"]["links"][0]["href"].split('/').pop.to_i

			else

				self.parent = nil

			end

		end

		def update_attributes(updated_product)

			self.lookupName = updated_product.lookupName

			self.createdTime = updated_product.createdTime

			self.updatedTime = updated_product.updatedTime

			self.name = updated_product.name

			self.parent = updated_product.parent

		end

		def self.check_self(obj,is_update = false)

			class_name = self.to_s.split('::')[1]

			obj_attrs = ValidationsModule::extract_attributes(obj)

			obj_attrs = ValidationsModule::check_interfaces(obj_attrs)

			if is_update == true
			
				obj_attrs = remove_unused_new_attrs(obj_attrs)
			
			else

				obj_attrs = ValidationsModule::check_for_names(obj_attrs,class_name)

				obj_attrs = ValidationsModule::check_for_parents(obj_attrs)
				
			end

			obj_attrs

		end

		def self.remove_unused_new_attrs(obj_attrs)

			obj_attrs[0].delete('id')
			
			obj_attrs[0].delete('lookupName')
			
			obj_attrs[0].delete('createdTime')
			
			obj_attrs[0].delete('updatedTime')
			
			obj_attrs[0].delete('name')
			
			if !obj_attrs[0]['parent'].nil?
			
				obj_attrs[0].delete('parent')
			
			end

			obj_attrs

		end

	end
	
end