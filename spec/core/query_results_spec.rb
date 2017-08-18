require 'core/spec_helper'
require 'json'
require 'uri'

describe OSCRuby::QueryResults do

	let(:client) { 

		OSCRuby::Client.new do |config|
		
			config.interface = ENV['OSC_SITE']
		
			config.username = ENV['OSC_ADMIN']
		
			config.password = ENV['OSC_PASSWORD']

			config.demo_site = true
		
		end
	}

	let(:query_results){
		OSCRuby::QueryResults.new
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

			expect(query_results.query(client,"describe answers;describe serviceproducts")).to be_an(Array)

			# expect(query_results.query(client,"describe answers;describe servicecategories")).not_to eq(nil)

			expect(query_results.query(client,"describe answers;describe servicecategories")).to be_an(Array)

		end

		it 'should be able to manipulate and assign results data',:vcr do 

			@incidents = query_results.query(client,"select * from incidents where ID > 2500 LIMIT 10")

			@incidents.each do |incident|

				expect(incident['id'].to_i).to be_a(Integer)

			end 

		end
		
	end

end	