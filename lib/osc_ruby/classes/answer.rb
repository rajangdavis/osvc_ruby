require 'osc_ruby/modules/nested_resource_module'

module OSCRuby
	
	class Answer < ServiceClass
		include NestedResourceModule
		
		attr_accessor :answerType, :language, :summary, :id, :lookupName, :createdTime, :updatedTime, :accessLevels, :name, :adminLastAccessTime, :expiresDate, :guidedAssistance, :keywords, :lastAccessTime, :lastNotificationTime, :nextNotificationTime, :originalReferenceNumber, :positionInList,
			:publishOnDate, :question, :solution, :updatedByAccount, :uRL, :categories

	    def initialize(attributes = nil)

			if attributes.nil?

   				@answerType = {}
   				@accessLevels = []
   				@summary = "Answer summary text"
   				@language = {}
   				@question = nil
   				@categories = []
   				@id = 0

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


	    # Convenience Methods for making the CRUD operations nicer to use

		def self.set_attributes(response_body)
	    	id = response_body['id'].to_i
			lookupName = response_body['lookupName'].to_i
			createdTime = response_body['createdTime']
			updatedTime = response_body['updatedTime']
			accessLevels = response_body['accessLevels']
			adminLastAccessTime = response_body['adminLastAccessTime']
			answerType = response_body['answerType']
			expiresDate = response_body['expiresDate']
			guidedAssistance = response_body['guidedAssistance']
			keywords = response_body['keywords']
			language = response_body['language']
			lastAccessTime = response_body['lastAccessTime']
			lastNotificationTime = response_body['lastNotificationTime']
			name = response_body['name'].to_i
			nextNotificationTime = response_body['nextNotificationTime']
			originalReferenceNumber = response_body['originalReferenceNumber']
			positionInList = response_body['positionInList']
			publishOnDate = response_body['publishOnDate']
			question = response_body['question']
			solution = response_body['solution']
			summary = response_body['summary']
			updatedByAccount = response_body['updatedByAccount']
			uRL = response_body['uRL']
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