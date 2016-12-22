require 'core/spec_helper'
require 'json'
require 'uri'

describe OSCRuby::Connect do
	
	subject { connect }
	
	let(:client) { 

		OSCRuby::Client.new do |config|
		
			config.interface = ENV['OSC_TEST_SITE']
		
			config.username = ENV['OSC_ADMIN']
		
			config.password = ENV['OSC_PASSWORD']
		
		end
	}

	context '#generate_url_and_config' do

		it 'should take at least a config parameter that is an instance of an OSCRuby::Client' do

			expect(client).to be_an(OSCRuby::Client)

			expect do

				OSCRuby::Connect.generate_url_and_config(client)

			end.not_to raise_error
		end

		it 'should take an optional resource_url parameter' do

			expect do

				OSCRuby::Connect.generate_url_and_config(client, 'serviceProducts')

			end.not_to raise_error
		end

		it 'should change the final configured url if the resource_url parameter is specified' do

			test = OSCRuby::Connect.generate_url_and_config(client, 'serviceProducts')

			interface = client.config.interface

			expect(test['site_url']).to eq(URI("https://#{interface}.custhelp.com/services/rest/connect/v1.3/serviceProducts"))

			expect(test['site_url']).to be_an(URI::HTTPS)
		end

		it 'should raise an error if client is nil' do

			expect do
				
				client = nil

				OSCRuby::Connect.generate_url_and_config(client)

			end.to raise_error("Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings")

		end

		it 'should raise an error if client.config is nil' do

			expect do
				
				client.config = nil

				OSCRuby::Connect.generate_url_and_config(client)

			end.to raise_error("Client configuration cannot be nil or blank")

		end

		it 'should raise an error if client interface is absent' do

			expect do
				
				client.config.interface = nil
				
				OSCRuby::Connect.generate_url_and_config(client)
			
			end.to raise_error("The configured client interface cannot be nil or blank")

		end

		it 'should raise an error if client username is absent' do

			expect do

				client.config.username = nil

				OSCRuby::Connect.generate_url_and_config(client)

			end.to raise_error("The configured client username cannot be nil or blank")

		end

		it 'should raise an error if client password is absent' do

			expect do

				client.config.password = nil

				OSCRuby::Connect.generate_url_and_config(client)

			end.to raise_error("The configured client password cannot be nil or blank")

		end


		it 'should create an Hash object with a site_url, username, password properties' do

			final_config = OSCRuby::Connect.generate_url_and_config(client)

			expect(final_config).to be_an(Hash)

			expect(final_config['site_url']).to be_an(URI::HTTPS)

			expect(final_config['username']).to eq(ENV['OSC_ADMIN'])

			expect(final_config['password']).to eq(ENV['OSC_PASSWORD'])

		end

	end

	let(:test){
		OSCRuby::Connect.get(client)
	}

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

		it 'should produce a Net::HTTPResponse' do

			expect(test).to be_an(Net::HTTPResponse)
				
		end

		it 'should produce a 200 response code' do

			expect(test.code).to eq("200")
				
		end

		it 'should produce a JSON Response form the response body' do
			
			expect(test.body).to be_an(String)

			expect{JSON.parse(test.body)}.not_to raise_error
		end

		let(:json_content){
			{:test => 'content'}
		}

		context '#post' do

			it 'should take at least a config parameter that is an instance of an OSCRuby::Client' do

				expect(client).to be_an(OSCRuby::Client)

				expect do

					OSCRuby::Connect.post(client,'serviceProducts',json_content)

				end.not_to raise_error
			end

			it 'should raise an error if client is nil' do

				expect do
					
					client = nil

					OSCRuby::Connect.post(client,'serviceProducts',json_content)

				end.to raise_error("Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings")

			end

			it 'should raise an error if resource_url is nil' do

				expect do

					OSCRuby::Connect.post(client,'serviceProducts')

				end.to raise_error("There is no json content provided; please specify json content that you would like to send a POST request with")

			end

			it 'should produce a Net::HTTPResponse, should produce a 201 response code, and should produce a JSON Response form the response body' do

				names = []

				names[0] = {:labelText => 'QTH45-test', :language => {:id => 1}}
				names[1] = {:labelText => 'QTH45-test', :language => {:id => 11}}

				parent = {:id => 102}

				displayOrder = {:id => 4}

				admin_user_visible_interfaces = []
				admin_user_visible_interfaces[0] = {:id => 1}

				end_user_visible_interfaces = []
				end_user_visible_interfaces[0] = {:id => 1}

				new_prod = []
				new_prod[0] = {:names => names, 
				               :parent => parent, 
				               :adminVisibleInterfaces => admin_user_visible_interfaces,
				               :endUserVisibleInterfaces => end_user_visible_interfaces}

			    test = OSCRuby::Connect.post(client,'serviceProducts',new_prod[0])

				expect(test).to be_an(Net::HTTPResponse)

				expect(test.code).to eq("201")

				expect(test.body).to be_an(String)

				expect{JSON.parse(test.body)}.not_to raise_error
					
			end

		end

	end

	context '#patch'

			
	end
end