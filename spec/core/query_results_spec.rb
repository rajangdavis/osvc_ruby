require 'core/spec_helper'
require 'json'
require 'uri'

describe OSCRuby::QueryResults do

	let(:client) { 

		OSCRuby::Client.new do |config|
		
			config.interface = ENV['OSC_TEST1_SITE']
		
			config.username = ENV['OSC_ADMIN']
		
			config.password = ENV['OSC_PASSWORD']
		
		end
	}

	let(:query_results){
		OSCRuby::QueryResults.new
	}



	let(:table){ "answers" } 
	let(:nested_attributes){
 		[ "*",
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


	context "#query" do

		it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

			expect(client).to be_an(OSCRuby::Client)

			client = nil

			expect{query_results.query(client,'describe')}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

		end

		it 'should expect a query' do

			expect(client).to be_an(OSCRuby::Client)

			expect{query_results.query(client,"")}.to raise_error("A query must be specified when using the 'query' method")

		end

		it 'should put results in array of hashes',:vcr do 

			# expect(query_results.query(client,"describe")).not_to eq(nil)

			expect(query_results.query(client,"describe")).to be_an(Array)

			# expect(query_results.query(client,"describe answers")).not_to eq(nil)

			expect(query_results.query(client,"describe answers;describe serviceproducts",true)).to be_an(Array)

			# expect(query_results.query(client,"describe answers;describe servicecategories")).not_to eq(nil)

			expect(query_results.query(client,"describe answers;describe servicecategories")).to be_an(Array)

		end

		it 'should be able to manipulate and assign results data',:vcr do 

			@answers = query_results.query(client,"select * from answers where ID > 2500")

			@answers.each do |answer|

				expect(answer['id'].to_i).to be_a(Integer)

				expect(answer['answerType']).not_to be(nil)

				expect(answer['answerType']).not_to eq("\n")

				expect{@answer = OSCRuby::Answer.new(answer)}.not_to raise_error

			end 

		end

		context "#nested_query" do

			it 'should take nested queries and return multiple objects',:vcr do

				query = nested_attributes.map{|q| "select #{table}.#{q} from #{table} where ID = 2222" }.join("; ")


				expect do
					
					results = query_results.nested_query(client,query,true)
					expect(results.length).to eq(nested_attributes.length)

					puts "Results : #{results.length} | Queries: #{nested_attributes.length}"

				end.not_to raise_error


				
			end

		end
		
	end

end	