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

	context '#generate_url' do
	end

	context '#get' do

		it 'should take at least a config parameter that is an instance of an OSCRuby::Client' do

			expect(client).to be_an(OSCRuby::Client)

			expect do
				OSCRuby::Connect.get(client)
			end.not_to raise_error
		end

		it 'should raise an error if client is nil' do

			expect do
				client = nil
				OSCRuby::Connect.get(client)
			end.to raise_error("Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings")

		end

		it 'should raise an error if client.config is nil' do

			expect do
				client.config = nil
				OSCRuby::Connect.get(client)
			end.to raise_error("Client configuration cannot be nil or blank")

		end

		it 'should raise an error if client interface is absent' do

			expect do
				client.config.interface = nil
				OSCRuby::Connect.get(client)
			end.to raise_error("The configured client interface cannot be nil or blank")

		end

		it 'should raise an error if client username is absent' do

			expect do
				client.config.username = nil
				OSCRuby::Connect.get(client)
			end.to raise_error("The configured client username cannot be nil or blank")

		end

		it 'should raise an error if client password is absent' do

			expect do
				client.config.password = nil
				OSCRuby::Connect.get(client)
			end.to raise_error("The configured client password cannot be nil or blank")

		end

		# it 'should produce a JSON Response' do
		# 	expect do
		

		# 		client.connect.should_be a('String')
		# 	end
		# end
	end
end