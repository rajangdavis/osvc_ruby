module OSCRuby

	class Account < ServiceClass

		attr_accessor :displayName,:login,:name,:nameFurigana,:attributes,:profile,:name,:staffGroup,:newPassword,:country,:emails

	    def initialize(attributes = nil)

	    	@displayName = 'Display Name'
	    	@login = 'Login'
	    	@name = {}
	    	@nameFurigana = {}
	    	@attributes = {}
	    	@profile = {}
	    	@name = {}
	    	@staffGroup = {}
	    	@newPassword = 'default_password'
	    	@country = {}
	    	@emails = []

	    end

	    # Convenience Methods for making the CRUD operations nicer to use

		def set_attributes(response_body)

			self.id = response_body["id"]

    		self.name = response_body["lookupName"]

    		self.lookupName = response_body["lookupName"]

			self.displayOrder = response_body["displayOrder"]

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

			# if is_update == true
			
			# 	obj_attrs = remove_unused_new_attrs(obj_attrs)
			
			# else

			# 	obj_attrs = ValidationsModule::check_for_names(obj_attrs,class_name)

			# 	obj_attrs = ValidationsModule::check_for_parents(obj_attrs)
				
			# end

			obj_attrs

		end

	end
	
end