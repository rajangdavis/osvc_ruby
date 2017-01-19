require 'core/spec_helper'
require 'json'
require 'uri'

describe OSCRuby::QueryResults do

	let(:client) { 

		OSCRuby::Client.new do |config|
		
			config.interface = ENV['OSC_TEST_SITE']
		
			config.username = ENV['OSC_ADMIN']
		
			config.password = ENV['OSC_PASSWORD']
		
		end
	}

	let(:query_results){
		OSCRuby::QueryResults.new
	}

	context "#select" do

		it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

			expect(client).to be_an(OSCRuby::Client)

			client = nil

			expect{query_results.select(client,'describe')}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

		end

		it 'should expect a query ' do

			expect(client).to be_an(OSCRuby::Client)

			expect{query_results.select(client,"")}.to raise_error("A query must be specified when using the 'select' method")

		end
		
	end

end