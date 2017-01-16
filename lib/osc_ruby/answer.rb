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

			ClassFactoryModule.create(client,self,"/answers",return_json)

	    end


	    def self.find(client,id = nil,return_json = false)

	    	ClassFactoryModule.find(client,id,'answers',return_json,OSCRuby::Answer)

	    end


	    def self.all(client, return_json = false)

	    	ClassFactoryModule.all(client,'answers',return_json,OSCRuby::Answer)

	    end

	    def self.where(client, query = '', return_json = false)

	    	ClassFactoryModule.where(client,query,'answers',return_json,OSCRuby::Answer)

	    end

	    def update(client, return_json = false)

	    	ClassFactoryModule::update(client,self,"answers",return_json)

	    end

	    def destroy(client, return_json = false)

	    	ClassFactoryModule.destroy(client,self,'answers',return_json)

	    end











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

		def self.check_self(obj,is_update = false)

			obj_attrs = ValidationsModule::extract_attributes(obj)

			if is_update == false

				obj_attrs = check_for_language_and_type(obj_attrs)
				
			end

			obj_attrs

		end

		def self.check_for_language_and_type(obj_attrs)

			if ValidationsModule::attr_hash_exists_and_is_type_of(obj_attrs,'language','id',Fixnum)
				
				raise ArgumentError, 'Answer should at least the language, answerType, and summary set (new_answer.language = {"id" => 1}; new_answer.answerType = {"id" => 1}}; new_answer.summary = "This is the Answer Title")'
			
			end
			
			if ValidationsModule::attr_hash_exists_and_is_type_of(obj_attrs,'answerType','id',Fixnum) && 
				ValidationsModule::attr_hash_exists_and_is_type_of(obj_attrs,'answerType','lookupName',String)
				
				raise ArgumentError, 'Answer should at least the language, answerType, and summary set (new_answer.language = {"id" => 1}; new_answer.answerType = {"id" => 1}}; new_answer.summary = "This is the Answer Title")'

			end

			obj_attrs

		end

	end

end