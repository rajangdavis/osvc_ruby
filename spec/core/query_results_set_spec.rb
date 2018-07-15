require 'core/spec_helper'
require 'json'
require 'uri'

describe OSvCRuby::QueryResultsSet do

	let(:client) { 

		OSvCRuby::Client.new do |config|
		
			config.interface = ENV['OSC_SITE']
		
			config.username = ENV['OSC_ADMIN']
		
			config.password = ENV['OSC_PASSWORD']

			config.demo_site = true
		
		end
	}

	let(:query_results_set){
		OSvCRuby::QueryResultsSet.new
	}

	let(:table){ "answers" } 
	let(:nested_attributes){
 		[ 
		  "accessLevels.namedIDList.*",
		  "answerType.*",
		  "assignedTo.account.*",
		  "assignedTo.staffGroup.*",
		  "banner.*",
		  "banner.importanceFlag.*",
		  "banner.updatedByAccount.*",
		  "categories.categoriesList.*",
		  "commonAttachments.fileAttachmentList.*",
		  "commonAttachments.fileAttachmentList.names.labelList.labelText",
		  "commonAttachments.fileAttachmentList.names.labelList.language.*",
		  "fileAttachments.fileAttachmentList.*",
		  "guidedAssistance.*",
		  "language.*",
		  "notes.noteList.*",
		  "positionInList.*",
		  "products.productsList.*",
		  "relatedAnswers.answerRelatedAnswerList.*",
		  "relatedAnswers.answerRelatedAnswerList.toAnswer.*",
		  "siblingAnswers.*",
		  "statusWithType.statusType.*",
		  "updatedByAccount.*",
		  "customFields.c.*"
		]
	}


	context "#query_set" do

		it 'should expect client is an instance of OSvCRuby::Client class and raise an error if does not' do

			expect(client).to be_an(OSvCRuby::Client)

			client = nil

			expect{query_results_set.query_set(client,{key:"answers", query:"select * from answers LIMIT 2"})}.to raise_error('Client must have some configuration set; please create an instance of OSvCRuby::Client with configuration settings')

		end


		## TO DO

		# it 'should expect a hash with a key and query value set' do

		# 	expect(client).to be_an(OSvCRuby::Client)

		# 	expect{query_results_set.query_set(client,"")}.to raise_error("A query must be specified when using the 'query' method")

		# end


		it 'should return results in set of OSvCRuby::QueryResults',:vcr do 

			expect(query_results_set.query_set(client,{key:"answers", query:"select * from answers LIMIT 2"},
													  {key:"incidents", query:"describe incidents"})).to be_a(Struct)


		end

		it 'should be able to manipulate and assign results data',:vcr do 

			test = query_results_set.query_set(client, {key:"incidents", query:"select * from incidents limit 10"},
													   {key:"serviceCategories", query:"describe serviceCategories"})		
				expect(test.incidents).to be_an(Array)
				expect(test.incidents.first).to be_a(Hash)
				expect(test.incidents.first['id']).to be_a(Integer)
				expect(test.serviceCategories).to be_an(Array)


		end

		it 'should be able to take multiple queries', :vcr do
			answer_attrs = nested_attributes.map { |attr| {key: attr, query: "SELECT #{attr} FROM #{table} WHERE ID = 1"} }
			test = query_results_set.query_set(client,*answer_attrs)
		end
		
	end

end	