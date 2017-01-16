require 'osc_ruby/client'
require 'osc_ruby/query_module'
require 'osc_ruby/validations_module'
require 'osc_ruby/class_factory_module'
require 'json'
require 'uri'

module OSCRuby
	
	class Answer

		include QueryModule
		include ValidationsModule
		include ClassFactoryModule
		
		attr_accessor :answerType, :language, :summary, :id, :lookupName, :createdTime, :updatedTime, :accessLevels, :name, :adminLastAccessTime, :expiresDate, :guidedAssistance, :keywords, :lastAccessTime, :lastNotificationTime, :nextNotificationTime, :originalReferenceNumber, :positionInList,
			:publishOnDate, :question, :solution, :updatedByAccount, :uRL

	    def initialize(attributes = nil)

			if attributes.nil?

   				@answerType = {}
   				
   				@summary = "Answer summary text"
   				
   				@language = {}

   				@question = nil

			else

				@id = attributes["id"]
		      
				@lookupName = attributes["lookupName"]
		      
				@createdTime = attributes["createdTime"]
		      
				@updatedTime = attributes["updatedTime"]

				@accessLevels = attributes["accessLevels"]
		      
				@name = attributes["name"]
		      
				@adminLastAccessTime = attributes["adminLastAccessTime"]

				@answerType = attributes["answerType"]

				@expiresDate = attributes["expiresDate"]

				@guidedAssistance = attributes["guidedAssistance"]

				@keywords = attributes["keywords"]

				@language = attributes["language"]

				@lastAccessTime = attributes["lastAccessTime"]

				@lastNotificationTime = attributes["lastNotificationTime"]

				@nextNotificationTime = attributes["nextNotificationTime"]

				@originalReferenceNumber = attributes["originalReferenceNumber"]

				@positionInList = attributes["positionInList"]

				@publishOnDate = attributes["publishOnDate"]

				@question = attributes["question"]

				@solution = attributes["solution"]

				@summary = attributes["summary"]

				@updatedByAccount = attributes["updatedByAccount"]

				@uRL = attributes["uRL"]

			end

	    end

	    def create(client,return_json = false)

	    	ValidationsModule::check_client(client)

	    	new_answer = self

	    	final_json = self.class.check_self(new_answer)

	    	resource = URI.escape("/answers")

	    	response = QueryModule::create(client,resource,final_json)

	    	response_body = JSON.parse(response.body)

	    	if response.code.to_i == 201 && return_json == false

				set_attributes(response_body)

	    	elsif return_json == true

	    		response.body

	    	end

	    end

	    def self.find(client,id = nil,return_json = false)

	    	ClassFactoryModule.find(client,id,'answers',return_json,OSCRuby::Answer)

	    end


# 	    def self.all(client, return_json = false)

# 	    	ValidationsModule::check_client(client)
	    	
# 	    	resource = URI.escape("queryResults/?query=select * from Answers")

# 	    	service_product_json = QueryModule::find(client,resource)

# 	    	if return_json == true

# 	    		service_product_json

# 	    	else

# 		    	service_product_json_final = JSON.parse(service_product_json)

# 		    	service_product_json_final.map { |attributes| new_from_fetch(attributes) }

# 		    end

# 	    end

# 	    def self.where(client, query = '', return_json = false)

# 	    	ValidationsModule::check_client(client)

# 	    	ValidationsModule::check_query(query)

# 	    	@query = URI.escape("queryResults/?query=select * from Answers where #{query}")

# 	    	service_product_json = QueryModule::find(client,@query)

# 	    	if return_json == true

# 	    		service_product_json

# 	    	else

# 		    	service_product_json_final = JSON.parse(service_product_json)

# 		    	service_product_json_final.map { |attributes| new_from_fetch(attributes) }

# 		    end

# 	    end

# 	    def update(client, return_json = false)

# 	    	ValidationsModule::check_client(client)

# 	    	product_to_update = self

# 	    	self.class.check_for_id(product_to_update)

# 	    	final_json = self.class.check_self(product_to_update,true)

# 	    	resource = URI.escape("/Answers/#{product_to_update.id}")

# 	    	response = QueryModule::update(client,resource,final_json)

# 	    	if response.code.to_i == 200 && return_json == false

# 	    		updated_product = OSCRuby::Answer.find(client,product_to_update.id)

# 	    		self.lookupName = updated_product.lookupName

# 				self.createdTime = updated_product.createdTime

# 				self.updatedTime = updated_product.updatedTime

# 				self.name = updated_product.name

# 				self.parent = updated_product.parent

# 	    	elsif return_json == true

# 	    		response.body

# 	    	end

# 	    end

# 	    def destroy(client, return_json = false)

# 	    	ValidationsModule::check_client(client)

# 	    	product_to_destroy = self

# 	    	self.class.check_for_id(product_to_destroy)

# 	    	resource = URI.escape("/Answers/#{product_to_destroy.id}")

# 	    	response = QueryModule::destroy(client,resource)

# 	    	if response.code.to_i == 200 && return_json == false

# 	    		nil

# 	    	elsif return_json == true

# 	    		response.body

# 	    	end

# 	    end











	    # Convenience Methods for making the CRUD operations nicer to use

		def set_attributes(response_body)
	    	self.id = response_body['id'].to_i
			self.lookupName = response_body['lookupName'].to_i
			self.createdTime = response_body['createdTime']
			self.updatedTime = response_body['updatedTime']
			self.accessLevels = response_body['accessLevels']
			self.adminLastAccessTime = response_body['adminLastAccessTime']
			self.answerType = response_body['answerType']
			self.expiresDate = response_body['expiresDate']
			self.guidedAssistance = response_body['guidedAssistance']
			self.keywords = response_body['keywords']
			self.language = response_body['language']
			self.lastAccessTime = response_body['lastAccessTime']
			self.lastNotificationTime = response_body['lastNotificationTime']
			self.name = response_body['name'].to_i
			self.nextNotificationTime = response_body['nextNotificationTime']
			self.originalReferenceNumber = response_body['originalReferenceNumber']
			self.positionInList = response_body['positionInList']
			self.publishOnDate = response_body['publishOnDate']
			self.question = response_body['question']
			self.solution = response_body['solution']
			self.summary = response_body['summary']
			self.updatedByAccount = response_body['updatedByAccount']
			self.uRL = response_body['uRL']
		end

		def self.new_from_fetch(attributes)

	    	ValidationsModule::check_attributes(attributes)

	    	OSCRuby::Answer.new(attributes)

		end

		def self.check_self(obj,is_update = false)

			obj_attrs = ValidationsModule::extract_attributes(obj)

			if is_update == true
			
				obj_attrs = remove_unused_new_attrs(obj_attrs)
			
			else

				obj_attrs = check_for_language_and_type(obj_attrs)
				
			end

			obj_attrs

		end

		def self.check_for_language_and_type(obj_attrs)

			if attr_hash_exists_and_is_type_of(obj_attrs,'language','id',Fixnum)
				
				raise ArgumentError, 'Answer should at least the language, answerType, and summary set (new_answer.language = {"id" => 1}; new_answer.answerType = {"id" => 1}}; new_answer.summary = "This is the Answer Title")'
			
			end
			if attr_hash_exists_and_is_type_of(obj_attrs,'answerType','id',Fixnum) && 
				attr_hash_exists_and_is_type_of(obj_attrs,'answerType','lookupName',String)
				
				raise ArgumentError, 'Answer should at least the language, answerType, and summary set (new_answer.language = {"id" => 1}; new_answer.answerType = {"id" => 1}}; new_answer.summary = "This is the Answer Title")'

			end

			obj_attrs

		end

		def self.attr_hash_exists_and_is_type_of(obj,key,val,class_of_value)

			return obj[0][key][val].nil? || obj[0][key][val].class != class_of_value

		end

# 		def self.check_for_parents(obj_attrs)

# 			if !obj_attrs[0]['parent'].nil? && obj_attrs[0]['parent'].is_a?(Hash) && !obj_attrs[0]['parent'].key?('id') && !obj_attrs[0]['parent'].key?('lookupName')
			
# 				obj_attrs[0].delete('parent')
			
# 			end

# 			obj_attrs

# 		end

# 		def self.remove_unused_new_attrs(obj_attrs)

# 			obj_attrs[0].delete('id')
			
# 			obj_attrs[0].delete('lookupName')
			
# 			obj_attrs[0].delete('createdTime')
			
# 			obj_attrs[0].delete('updatedTime')
			
# 			obj_attrs[0].delete('name')
			
# 			if !obj_attrs[0]['parent'].nil?
			
# 				obj_attrs[0].delete('parent')
			
# 			end

# 			obj_attrs

# 		end

	end

end