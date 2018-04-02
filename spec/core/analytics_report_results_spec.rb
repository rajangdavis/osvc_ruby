require 'core/spec_helper'
require 'json'
require 'uri'

describe OSvCRuby::AnalyticsReportResults do

	let(:client) { 

		OSvCRuby::Client.new do |config|
		
			config.interface = ENV['OSC_SITE']
		
			config.username = ENV['OSC_ADMIN']
		
			config.password = ENV['OSC_PASSWORD']

			config.demo_site = true
		
		end
	}

	let(:last_updated){
		OSvCRuby::AnalyticsReportResults.new(lookupName: "Last Updated By Status")
	}

	let(:answers_search){
		OSvCRuby::AnalyticsReportResults.new(id: 176)
	}

	let(:error_example){
		OSvCRuby::AnalyticsReportResults.new
	}


	context "#initialize" do

		it "should expect an id or a lookupName for a report" do
			
			expect(last_updated).to be_an(OSvCRuby::AnalyticsReportResults)

			expect(last_updated.lookupName).to eq("Last Updated By Status")

			expect(answers_search).to be_an(OSvCRuby::AnalyticsReportResults)

			expect(answers_search.id).to eq(176)
		
		end


				
	end

	context "#run" do
		it 'should expect client is an instance of OSvCRuby::Client class and raise an error if does not' do

			expect(client).to be_an(OSvCRuby::Client)

			client = nil

			expect{answers_search.run(client)}.to raise_error('Client must have some configuration set; please create an instance of OSvCRuby::Client with configuration settings')

		end

		it 'should throw an error if there is no id or no lookupName assigned',:vcr do
			expect{error_example.run(client)}.to raise_error('AnalyticsReportResults must have an id or lookupName set')
			error_example.id = 176
			expect(error_example.run(client)).to be_an(Array)
		end

		it 'should be able to take filters', :vcr do
			keywords = arrf(name: "search_ex", values: "Maestro")
			answers_search.filters << keywords

			answers = answers_search.run(client)

			answers.each do |answer|

				expect(answer['Summary']).to be_a(String)
				expect(answer['Answer ID']).to be_a(Integer)
			end			

		end

	end

end	