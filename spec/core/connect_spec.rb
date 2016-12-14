require 'core/spec_helper'

describe OSCRuby::Connect do
	subject { connect }
	
	let(:client) { 
		OSCRuby::Client.new do |config|
			config.interface = ENV['OSC_TEST_SITE']
			config.username = ENV['OSC_ADMIN']
			config.password = ENV['OSC_PASSWORD']
		end
	}

	context '#get' do


		it 'should take at least a config parameter that is an instance of an OSCRuby::Client' do

			expect(client).to be_an(OSCRuby::Client)

			expect do
				OSCRuby::Connect.get(client)
			end.not_to raise_error
		end

		# it 'should raise an error if client is nil' do

		# 	expect do
		# 		OSCRuby::Connect.get(client)
		# 	end.to raise_error("Client cannot be nil or blank")

		# end

		# it 'should produce a JSON Response' do
		# 	expect do
		

		# 		client.connect.should_be a('String')
		# 	end
		# end
	end
end