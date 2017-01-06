require 'core/spec_helper'
require 'json'
require 'uri'

describe OSCRuby::ServiceProduct do

	let(:service_product){
		
		OSCRuby::ServiceProduct.new

	}

	context '#initialize' do

		it 'should not throw an error when initialized' do

			expect{service_product}.not_to raise_error

		end

		it 'should initialize with names being an array; parent is an empty hash; 
		displayOrder is 1; adminVisibleInterfaces is an empty array; and endUserVisibleInterfaces is an empty array' do

			expect(service_product.names).to eq([])

			expect(service_product.parent).to eq({})

			expect(service_product.displayOrder).to eq(1)

			expect(service_product.adminVisibleInterfaces).to eq([])

			expect(service_product.endUserVisibleInterfaces).to eq([])

		end

	end

	let(:attributes){
		{'id' => 1, 
		 'lookupName' => 'Test Product Lookup Name',
		 'createdTime'=>nil,
		 'updatedTime'=>nil,
		 'displayOrder'=>1,
		 'name'=>'Test Product Lookup Name',
		 'parent' => nil
		}
	}

	context '#new_from_fetch' do

		it 'should accept an attributes as a hash' do

			expect do

				attributes = []

				OSCRuby::ServiceProduct.new_from_fetch(attributes)

			end.to raise_error("Attributes must be a hash; please use the appropriate data structure")

			expect do

				OSCRuby::ServiceProduct.new_from_fetch(attributes)

			end.not_to raise_error

		end

		it 'should instantiate an id, lookupName, createdTime, updatedTime, displayOrder, name, and parent with the correct values' do

			test = OSCRuby::ServiceProduct.new_from_fetch(attributes)

			expect(test.id).to eq(1)

			expect(test.lookupName).to eq('Test Product Lookup Name')

			expect(test.createdTime).to eq(nil)

			expect(test.updatedTime).to eq(nil)

			expect(test.displayOrder).to eq(1)

			expect(test.name).to eq('Test Product Lookup Name')

			expect(test.name).to eq(test.lookupName)

			expect(test.parent).to eq(nil)

		end

	end

	let(:client) { 

		OSCRuby::Client.new do |config|
		
			config.interface = ENV['OSC_TEST_SITE']
		
			config.username = ENV['OSC_ADMIN']
		
			config.password = ENV['OSC_PASSWORD']
		
		end
	}

	let(:new_service_product){
		OSCRuby::ServiceProduct.new
	}

	context '#create' do

		it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

			expect(client).to be_an(OSCRuby::Client)

			client = nil

			expect{new_service_product.create(client)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

		end

		it 'should check the object and make sure that it at least has a name set' do

			expect{new_service_product.create(client)}.to raise_error('ServiceProduct should at least have one name set (new_service_product.names[0] = {"labelText" => "QTH45-test", "language" => {"id" => 1}} )')

		end

		it 'should expect the name in a hash as the value of the labelText key' do

			new_service_product.names[0] = "new product name"

			expect{new_service_product.create(client)}.to raise_error('ServiceProduct should at least have one name set (new_service_product.names[0] = {"labelText" => "QTH45-test", "language" => {"id" => 1}} )')

		end

		it 'should expect a language => id key pair within the hash' do

			new_service_product.names[0] = {"labelText" => "QTH45-test"}

			expect{new_service_product.create(client)}.to raise_error('ServiceProduct should at least have one name set (new_service_product.names[0] = {"labelText" => "QTH45-test", "language" => {"id" => 1}} )')

		end

		it 'should return an instance of an OSCRuby::ServiceProduct if the json_response param is set to false (which it is by default)' do

			new_service_product.names[0] = {"labelText" => "QTH45", "language" => {"id" => 1}}
			new_service_product.names[1] = {"labelText" => "QTH45", "language" => {"id" => 11}} 		

			new_service_product.parent = {'id' => 102}

			new_service_product.displayOrder = 4

			new_service_product.create(client)

			expect(new_service_product).to be_a(OSCRuby::ServiceProduct)

			expect(new_service_product.name).to eq("QTH45")

			expect(new_service_product.lookupName).to eq("QTH45")

			expect(new_service_product.displayOrder).to eq(4)

			expect(new_service_product.parent).to eq(102)

		end


		it 'should return the body object if the json_response param is set to true' do

			new_service_product.names[0] = {"labelText" => "QTH45-test", "language" => {"id" => 1}}
			new_service_product.names[1] = {'labelText' => 'QTH45-test', 'language' => {'id' => 11}} 	

			expect(new_service_product.create(client,true)).to be_a(String)

		end

	end

	context '#find' do

		it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

			expect(client).to be_an(OSCRuby::Client)

			client = nil

			expect{OSCRuby::ServiceProduct.find(client,100)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

		end

		it 'should raise an error if ID is undefined' do

			expect{OSCRuby::ServiceProduct.find(client)}.to raise_error('ID cannot be nil')

		end

		it 'should raise an error if ID is not an integer' do

			expect{OSCRuby::ServiceProduct.find(client, 'a')}.to raise_error('ID must be an integer')

		end

		it 'should return a warning if empty/no instances of the object can be found' do

			expect{OSCRuby::ServiceProduct.find(client, 1)}.to raise_error('There were no objects matching your query; please try again.')

		end

		let(:known_working_product){
			OSCRuby::ServiceProduct.find(client, 100)
		}

		it 'should return an instance of a new OSCRuby::ServiceProduct object with at least a name and displayOrder' do

			expect(known_working_product).to be_an(OSCRuby::ServiceProduct)

			expect(known_working_product.name).to eq('QR404')

			expect(known_working_product.displayOrder).to eq(3)

		end

		it 'should return the raw json response if the return_json parameter is set to true' do

			known_working_product_in_json = OSCRuby::ServiceProduct.find(client, 100, true)

			expect(known_working_product_in_json).to be_an(String)

		end

	end

	context '#all' do

		it 'should return multiple instances of OSCRuby::ServiceProduct' do

			products = OSCRuby::ServiceProduct.all(client)

			expect(products.size).to be > 0

			puts "Checking if OSCRuby::ServiceProduct.all produces multiple instances of products"

			products.each_with_index do |p,i|

				if i < 10

					expect(p).to be_an(OSCRuby::ServiceProduct)

				end

			end

		end

		it 'should just return JSON if the return_json parameter is set to true' do

			expect(OSCRuby::ServiceProduct.all(client,true)).to be_a(String)

		end

	end

	contect '#where' do

	end

end