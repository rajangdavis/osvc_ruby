require 'core/spec_helper'
require 'json'
require 'uri'

describe OSCRuby::ServiceCategory do

	let(:service_category){
		
		OSCRuby::ServiceCategory.new

	}

	context '#initialize' do

		it 'should not throw an error when initialized' do

			expect{service_category}.not_to raise_error

		end

		it 'should initialize with names being an array; parent is an empty hash; 
		displayOrder is 1; adminVisibleInterfaces is an empty array; and endUserVisibleInterfaces is an empty array' do

			expect(service_category.names).to eq([])

			expect(service_category.parent).to eq({})

			expect(service_category.displayOrder).to eq(1)

			expect(service_category.adminVisibleInterfaces).to eq([])

			expect(service_category.endUserVisibleInterfaces).to eq([])

		end

	end

	# let(:attributes){
	# 	{'id' => 1, 
	# 	 'lookupName' => 'Test category Lookup Name',
	# 	 'createdTime'=>nil,
	# 	 'updatedTime'=>nil,
	# 	 'displayOrder'=>1,
	# 	 'name'=>'Test Product Lookup Name',
	# 	 'parent' => nil
	# 	}
	# }

	# context '#new_from_fetch' do

	# 	it 'should accept an attributes as a hash' do

	# 		expect do

	# 			attributes = []

	# 			OSCRuby::ServiceCategory.new_from_fetch(attributes)

	# 		end.to raise_error("Attributes must be a hash; please use the appropriate data structure")

	# 		expect do

	# 			OSCRuby::ServiceCategory.new_from_fetch(attributes)

	# 		end.not_to raise_error

	# 	end

	# 	it 'should instantiate an id, lookupName, createdTime, updatedTime, displayOrder, name, and parent with the correct values' do

	# 		test = OSCRuby::ServiceCategory.new_from_fetch(attributes)

	# 		expect(test.id).to eq(1)

	# 		expect(test.lookupName).to eq('Test Product Lookup Name')

	# 		expect(test.createdTime).to eq(nil)

	# 		expect(test.updatedTime).to eq(nil)

	# 		expect(test.displayOrder).to eq(1)

	# 		expect(test.name).to eq('Test Product Lookup Name')

	# 		expect(test.name).to eq(test.lookupName)

	# 		expect(test.parent).to eq(nil)

	# 	end

	# end

	let(:client) { 

		OSCRuby::Client.new do |config|
		
			config.interface = ENV['OSC_TEST_SITE']
		
			config.username = ENV['OSC_ADMIN']
		
			config.password = ENV['OSC_PASSWORD']
		
		end
	}

	let(:new_service_category){
		OSCRuby::ServiceCategory.new
	}

	context '#create' do

		it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

			expect(client).to be_an(OSCRuby::Client)

			client = nil

			expect{new_service_category.create(client)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

		end

		it 'should check the object and make sure that it at least has a name set' do

			expect{new_service_category.create(client)}.to raise_error('ServiceCategory should at least have one name set (new_service_category.names[0] = {"labelText" => "QTH45-test", "language" => {"id" => 1}} )')

		end

		it 'should expect the name in a hash as the value of the labelText key' do

			new_service_category.names[0] = "new category name"

			expect{new_service_category.create(client)}.to raise_error('ServiceCategory should at least have one name set (new_service_category.names[0] = {"labelText" => "QTH45-test", "language" => {"id" => 1}} )')

		end

		it 'should expect a language => id key pair within the hash' do

			new_service_category.names[0] = {"labelText" => "New Category"}

			expect{new_service_category.create(client)}.to raise_error('ServiceCategory should at least have one name set (new_service_category.names[0] = {"labelText" => "QTH45-test", "language" => {"id" => 1}} )')

		end

		it 'should return an instance of an OSCRuby::ServiceCategory if the json_response param is set to false (which it is by default)', :vcr do

			new_service_category.names[0] = {"labelText" => "TEST-CATEGORY", "language" => {"id" => 1}}
			new_service_category.names[1] = {"labelText" => "TEST-CATEGORY", "language" => {"id" => 11}} 	

			new_service_category.parent = {'id' => 6}	

			new_service_category.displayOrder = 1

			new_service_category.create(client)

			expect(new_service_category).to be_a(OSCRuby::ServiceCategory)

			expect(new_service_category.name).to eq("TEST-CATEGORY")

			expect(new_service_category.lookupName).to eq("TEST-CATEGORY")

			expect(new_service_category.displayOrder).to eq(1)

		end


		it 'should return the body object if the json_response param is set to true', :vcr do

			new_service_category.displayOrder = 11

			new_service_category.parent = {'id' => 6}

			new_service_category.names[0] = {"labelText" => "TEST-CATEGORY", "language" => {"id" => 1}}
			new_service_category.names[1] = {'labelText' => 'TEST-CATEGORY', 'language' => {'id' => 11}} 	

			expect(new_service_category.create(client,true)).to be_a(String)

		end

	end

	context '#find' do

		it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

			expect(client).to be_an(OSCRuby::Client)

			client = nil

			expect{OSCRuby::ServiceCategory.find(client,6)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

		end

		it 'should raise an error if ID is undefined' do

			expect{OSCRuby::ServiceCategory.find(client)}.to raise_error('ID cannot be nil')

		end

		it 'should raise an error if ID is not an integer' do

			expect{OSCRuby::ServiceCategory.find(client, 'a')}.to raise_error('ID must be an integer')

		end

		it 'should return a warning if empty/no instances of the object can be found', :vcr do

			expect{OSCRuby::ServiceCategory.find(client, 1)}.to raise_error('There were no objects matching your query; please try again.')

		end


		it 'should return an instance of a new OSCRuby::ServiceCategory object with at least a name and displayOrder', :vcr do
		
			known_working_category = OSCRuby::ServiceCategory.find(client, 6)

			expect(known_working_category).to be_an(OSCRuby::ServiceCategory)

			expect(known_working_category.name).to eq('Manuals & Guides')

			expect(known_working_category.displayOrder).to eq(2)

		end

		it 'should return the raw json response if the return_json parameter is set to true', :vcr do

			known_working_category_in_json = OSCRuby::ServiceCategory.find(client, 6, true)

			expect(known_working_category_in_json).to be_an(String)

		end

	end

	context '#all' do

		it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

			expect(client).to be_an(OSCRuby::Client)

			client = nil

			expect{OSCRuby::ServiceCategory.all(client)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

		end

		it 'should return multiple instances of OSCRuby::ServiceCategory', :vcr do

			categories = OSCRuby::ServiceCategory.all(client)

			expect(categories.size).to be > 0

			# puts "Checking if OSCRuby::ServiceCategory.all produces multiple instances of categories"

			categories.each_with_index do |p,i|

				if i < 10

					expect(p).to be_an(OSCRuby::ServiceCategory)

					# puts p.name

				end

			end

		end

		it 'should just return JSON if the return_json parameter is set to true', :vcr do

			expect(OSCRuby::ServiceCategory.all(client,true)).to be_a(String)

		end

	end

	context '#where' do

		it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

			expect(client).to be_an(OSCRuby::Client)

			client = nil

			expect{OSCRuby::ServiceCategory.where(client,'query')}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

		end

		it 'should raise an error if there is no query' do

			expect{OSCRuby::ServiceCategory.where(client)}.to raise_error('A query must be specified when using the "where" method')

		end

		it 'should take a query and return results', :vcr do

			categories_lvl_1 = OSCRuby::ServiceCategory.where(client,"parent is null and lookupname not like 'Unsure'")

			expect(categories_lvl_1.count).to be > 0

			categories_lvl_1.each_with_index do |p,i|

				if i < 10

					expect(p).to be_an(OSCRuby::ServiceCategory)

					# puts p.name

				end

			end

		end

		it 'should raise an error if the query returns 0 results', :vcr do

			expect{OSCRuby::ServiceCategory.where(client,"parent = 6546546546546")}.to raise_error('There were no objects matching your query; please try again.')

		end

		it 'should just return JSON if the return_json parameter is set to true', :vcr do

			parents = OSCRuby::ServiceCategory.where(client,"parent is null and lookupname not like 'Unsure'",true)

			expect(parents).to be_a(String)

			# puts parents

		end

	end

		

	context '#update' do

		it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not', :vcr do

			known_working_category = OSCRuby::ServiceCategory.find(client, 6)

			expect(client).to be_an(OSCRuby::Client)

			client = nil

			expect{known_working_category.update(client)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

		end

		it 'should expect that the Service Category is an instance of a OSCRuby::ServiceCategory', :vcr do

			known_working_category = OSCRuby::ServiceCategory.find(client, 6)

			expect(known_working_category).to be_an(OSCRuby::ServiceCategory)

		end

		it 'should expect that the category has an ID and spit out an error if it does not', :vcr do

			known_working_category = OSCRuby::ServiceCategory.find(client, 6)

			known_working_category.id = nil

			expect{known_working_category.destroy(client)}.to raise_error('OSCRuby::ServiceCategory must have a valid ID set')
		
		end

		it 'should update name when the names is updated', :vcr do

			test_prods = OSCRuby::ServiceCategory.where(client,"name like 'TEST-CATEGORY'")
			first_prod = test_prods[0]

			first_prod.names[0] = {"labelText" => "TEST-CATEGORY-UPDATED", "language" => {"id" => 1}}

			first_prod.update(client)

			expect(first_prod.name).to eq('TEST-CATEGORY-UPDATED')

		end

		it 'should just return JSON if the return_json parameter is set to true', :vcr do

			known_working_category = OSCRuby::ServiceCategory.find(client, 6)

			test = known_working_category.update(client,true)

			expect(test).to be_a(String)

		end

	end

	context '#destroy' do

		it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not', :vcr do

			test_prods = OSCRuby::ServiceCategory.where(client,"name like 'TEST-CATEGORY-UPDATED'")
			category_to_delete = test_prods[0]

			expect(client).to be_an(OSCRuby::Client)

			client = nil

			expect{category_to_delete.destroy(client)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

		end

		it 'should expect that the Service Category is an instance of a OSCRuby::ServiceCategory', :vcr do

			test_prods = OSCRuby::ServiceCategory.where(client,"name like 'TEST-CATEGORY-UPDATED'")
			category_to_delete = test_prods[0]

			expect(category_to_delete).to be_an(OSCRuby::ServiceCategory)

		end

		it 'should expect that the category has an ID and spit out an error if it does not', :vcr do

			test_prods = OSCRuby::ServiceCategory.where(client,"name like 'TEST-CATEGORY-UPDATED'")
			category_to_delete = test_prods[0]

			category_to_delete.id = nil

			expect{category_to_delete.destroy(client)}.to raise_error('OSCRuby::ServiceCategory must have a valid ID set')
		
		end

		it 'should delete the category', :vcr do

			test_prods = OSCRuby::ServiceCategory.where(client,"name like 'TEST-CATEGORY-UPDATED'")
			category_to_delete = test_prods[0]

			id_to_find = category_to_delete.id

			category_to_delete.destroy(client)

			expect{OSCRuby::ServiceCategory.find(client, id_to_find)}.to raise_error('There were no objects matching your query; please try again.')
		
		end

	end

end