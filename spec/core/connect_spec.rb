require 'core/spec_helper'
require 'json'
require 'uri'

describe OSCRuby::Connect do
	
	subject { connect }
	
	let(:client) { 

		OSCRuby::Client.new do |config|
		
			config.interface = ENV['OSC_SITE']
		
			config.username = ENV['OSC_ADMIN']
		
			config.password = ENV['OSC_PASSWORD']

			config.suppress_rules = true

			config.demo_site = true
		
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
			if test['site_url'].to_s.match(/custhelp/)
				demo_or_cust = "custhelp"
			else
				demo_or_cust = "rightnowdemo"
			end
			expect(test['site_url']).to eq(URI("https://#{interface}.#{demo_or_cust}.com/services/rest/connect/v1.3/serviceProducts"))

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

	let(:json_content){
		{:test => 'content'}
	}

	context '#post_or_patch' do

		it 'should take at least a config parameter that is an instance of an OSCRuby::Client', :vcr do

			expect(client).to be_an(OSCRuby::Client)

			expect do

				OSCRuby::Connect.post_or_patch(client,'serviceProducts',json_content)

			end.not_to raise_error
		end

		it 'should raise an error if client is nil' do

			expect do
				
				client = nil

				OSCRuby::Connect.post_or_patch(client,'serviceProducts',json_content)

			end.to raise_error("Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings")

		end

		it 'should raise an error if resource_url is nil' do

			expect do

				OSCRuby::Connect.post_or_patch(client, nil, json_content)

			end.to raise_error("There is no URL resource provided; please specify a URL resource that you would like to send a POST or PATCH request to")

		end

		it 'should raise an error if json_content is nil' do

			expect do

				OSCRuby::Connect.post_or_patch(client,'serviceProducts')

			end.to raise_error("There is no json content provided; please specify json content that you would like to send a POST or PATCH request with")

		end

		it 'should produce a Net::HTTPResponse, should produce a 201 response code, and should produce a JSON Response form the response body', :vcr do

			names = []

			names[0] = {:labelText => 'PRODUCT-TEST', :language => {:id => 1}}
			# names[1] = {:labelText => 'PRODUCT-TEST', :language => {:id => 11}}

			# parent = {:id => 102}

			displayOrder = {:id => 4}

			admin_user_visible_interfaces = []
			admin_user_visible_interfaces[0] = {:id => 1}

			end_user_visible_interfaces = []
			end_user_visible_interfaces[0] = {:id => 1}

			new_prod = []
			new_prod[0] = {:names => names,
			               :adminVisibleInterfaces => admin_user_visible_interfaces,
			               :endUserVisibleInterfaces => end_user_visible_interfaces}

		    test = OSCRuby::Connect.post_or_patch(client,'serviceProducts',new_prod[0])

			expect(test).to be_an(Net::HTTPResponse)

			expect(test.code).to eq("201")

			expect(test.body).to be_an(String)

			expect{JSON.parse(test.body)}.not_to raise_error
				
		end

	end	

	context '#get' do

		it 'should take at least a config parameter that is an instance of an OSCRuby::Client', :vcr do

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

		it 'should produce a Net::HTTPResponse', :vcr do

			test = OSCRuby::Connect.get(client)

			expect(test).to be_an(Net::HTTPResponse)
				
		end

		it 'should produce a 200 response code', :vcr do

			test = OSCRuby::Connect.get(client)

			expect(test.code).to eq("200")
				
		end

		it 'should produce a JSON Response from the response body', :vcr do

			test = OSCRuby::Connect.get(client)
			
			expect(test.body).to be_an(String)

			expect{JSON.parse(test.body)}.not_to raise_error
		end

	end


	context '#post_or_patch' do

		it 'should take an optional parameter to allow PATCH request; it should produce a Net::HTTPResponse, should produce a 200 code', :vcr do

			resource = URI.escape("queryResults/?query=select id from serviceproducts where lookupname = 'PRODUCT-TEST';")

			product_test = OSCRuby::Connect.get(client,resource)

			prod_json = JSON.parse(product_test.body).to_hash

			product_test_id = prod_json['items'][0]['rows'][0][0].to_i

			names = []

			names[0] = {:labelText => 'PRODUCT-TEST-updated', :language => {:id => 1}}
			# names[1] = {:labelText => 'PRODUCT-TEST-updated', :language => {:id => 11}}

			# parent = {:id => 102}

			displayOrder = {:id => 4}

			admin_user_visible_interfaces = []
			admin_user_visible_interfaces[0] = {:id => 1}

			end_user_visible_interfaces = []
			end_user_visible_interfaces[0] = {:id => 1}

			new_prod = []
			new_prod[0] = {:names => names, 
			               # :parent => parent, 
			               :adminVisibleInterfaces => admin_user_visible_interfaces,
			               :endUserVisibleInterfaces => end_user_visible_interfaces}

		    test = OSCRuby::Connect.post_or_patch(client,"serviceProducts/#{product_test_id}",new_prod[0],true)

			expect(test).to be_an(Net::HTTPResponse)

			expect(test.body).to eq("")

			expect(test.code).to eq("200")
				
		end

	end

	context '#delete' do

		it 'should raise an error if client is nil' do

			expect do
				
				client = nil

				OSCRuby::Connect.delete(client)

			end.to raise_error("Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings")

		end

		it 'should raise an error if the resource_url is not specified' do

			expect do

				OSCRuby::Connect.delete(client)

			end.to raise_error("There is no URL resource provided; please specify a URL resource that you would like to send a POST or PATCH request to")

		end

		it 'it should produce a Net::HTTPResponse, should produce a 200 code', :vcr do

			resource = URI.escape("queryResults/?query=select id from serviceproducts where lookupname = 'PRODUCT-TEST-updated';")

			product_test_updated = OSCRuby::Connect.get(client,resource)

			prod_json = JSON.parse(product_test_updated.body).to_hash

			product_test_updated_id = prod_json['items'][0]['rows'][0][0].to_i

		    test = OSCRuby::Connect.delete(client,"serviceProducts/#{product_test_updated_id}")

			expect(test).to be_an(Net::HTTPResponse)

			expect(test.body).to eq("")

			expect(test.code).to eq("200")
				
		end

	end

end