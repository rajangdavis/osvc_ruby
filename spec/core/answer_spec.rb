require 'core/spec_helper'
require 'json'
require 'uri'

describe OSCRuby::Answer do

	let(:answer){
		
		OSCRuby::Answer.new

	}

	context '#initialize' do

		it 'should not throw an error when initialized' do

			expect{answer}.not_to raise_error

		end

		it 'should initialize with answerType as a hash, language as a hash, and summary as a string' do

			expect(answer.answerType).to eq({})

			expect(answer.language).to eq({})

			expect(answer.summary).to eq('Answer summary text')

		end

	end

	# let(:attributes){
	# 	{'id' => 1, 
	# 	 'lookupName' => 'Test Product Lookup Name',
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

	# 			OSCRuby::Answer.new_from_fetch(attributes)

	# 		end.to raise_error("Attributes must be a hash; please use the appropriate data structure")

	# 		expect do

	# 			OSCRuby::Answer.new_from_fetch(attributes)

	# 		end.not_to raise_error

	# 	end

	# 	it 'should instantiate an id, lookupName, createdTime, updatedTime, displayOrder, name, and parent with the correct values' do

	# 		test = OSCRuby::Answer.new_from_fetch(attributes)

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

	# let(:client) { 

	# 	OSCRuby::Client.new do |config|
		
	# 		config.interface = ENV['OSC_TEST_SITE']
		
	# 		config.username = ENV['OSC_ADMIN']
		
	# 		config.password = ENV['OSC_PASSWORD']
		
	# 	end
	# }

	# let(:new_answer){
	# 	OSCRuby::Answer.new
	# }

	# context '#create' do

	# 	it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

	# 		expect(client).to be_an(OSCRuby::Client)

	# 		client = nil

	# 		expect{new_answer.create(client)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

	# 	end

	# 	it 'should check the object and make sure that it at least has a name set' do

	# 		expect{new_answer.create(client)}.to raise_error('Answer should at least have one name set (new_answer.names[0] = {"labelText" => "QTH45-test", "language" => {"id" => 1}} )')

	# 	end

	# 	it 'should expect the name in a hash as the value of the labelText key' do

	# 		new_answer.names[0] = "new product name"

	# 		expect{new_answer.create(client)}.to raise_error('Answer should at least have one name set (new_answer.names[0] = {"labelText" => "QTH45-test", "language" => {"id" => 1}} )')

	# 	end

	# 	it 'should expect a language => id key pair within the hash' do

	# 		new_answer.names[0] = {"labelText" => "QTH45-test"}

	# 		expect{new_answer.create(client)}.to raise_error('Answer should at least have one name set (new_answer.names[0] = {"labelText" => "QTH45-test", "language" => {"id" => 1}} )')

	# 	end

	# 	it 'should return an instance of an OSCRuby::Answer if the json_response param is set to false (which it is by default)', :vcr do

	# 		new_answer.names[0] = {"labelText" => "TEST-PRODUCT", "language" => {"id" => 1}}
	# 		new_answer.names[1] = {"labelText" => "TEST-PRODUCT", "language" => {"id" => 11}} 		

	# 		new_answer.parent = {'id' => 102}

	# 		new_answer.displayOrder = 4

	# 		new_answer.create(client)

	# 		expect(new_answer).to be_a(OSCRuby::Answer)

	# 		expect(new_answer.name).to eq("TEST-PRODUCT")

	# 		expect(new_answer.lookupName).to eq("TEST-PRODUCT")

	# 		expect(new_answer.displayOrder).to eq(4)

	# 		expect(new_answer.parent).to eq(102)

	# 	end


	# 	it 'should return the body object if the json_response param is set to true', :vcr do

	# 		new_answer.names[0] = {"labelText" => "TEST-PRODUCT", "language" => {"id" => 1}}
	# 		new_answer.names[1] = {'labelText' => 'TEST-PRODUCT', 'language' => {'id' => 11}} 	

	# 		expect(new_answer.create(client,true)).to be_a(String)

	# 	end

	# end

	# context '#find' do

	# 	it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

	# 		expect(client).to be_an(OSCRuby::Client)

	# 		client = nil

	# 		expect{OSCRuby::Answer.find(client,100)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

	# 	end

	# 	it 'should raise an error if ID is undefined' do

	# 		expect{OSCRuby::Answer.find(client)}.to raise_error('ID cannot be nil')

	# 	end

	# 	it 'should raise an error if ID is not an integer' do

	# 		expect{OSCRuby::Answer.find(client, 'a')}.to raise_error('ID must be an integer')

	# 	end

	# 	it 'should return a warning if empty/no instances of the object can be found', :vcr do

	# 		expect{OSCRuby::Answer.find(client, 1)}.to raise_error('There were no objects matching your query; please try again.')

	# 	end


	# 	it 'should return an instance of a new OSCRuby::Answer object with at least a name and displayOrder', :vcr do
		
	# 		known_working_product = OSCRuby::Answer.find(client, 100)

	# 		expect(known_working_product).to be_an(OSCRuby::Answer)

	# 		expect(known_working_product.name).to eq('QR404')

	# 		expect(known_working_product.displayOrder).to eq(3)

	# 	end

	# 	it 'should return the raw json response if the return_json parameter is set to true', :vcr do

	# 		known_working_product_in_json = OSCRuby::Answer.find(client, 100, true)

	# 		expect(known_working_product_in_json).to be_an(String)

	# 	end

	# end

	# context '#all' do

	# 	it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

	# 		expect(client).to be_an(OSCRuby::Client)

	# 		client = nil

	# 		expect{OSCRuby::Answer.all(client)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

	# 	end

	# 	it 'should return multiple instances of OSCRuby::Answer', :vcr do

	# 		products = OSCRuby::Answer.all(client)

	# 		expect(products.size).to be > 0

	# 		# puts "Checking if OSCRuby::Answer.all produces multiple instances of products"

	# 		products.each_with_index do |p,i|

	# 			if i < 10

	# 				expect(p).to be_an(OSCRuby::Answer)

	# 				# puts p.name

	# 			end

	# 		end

	# 	end

	# 	it 'should just return JSON if the return_json parameter is set to true', :vcr do

	# 		expect(OSCRuby::Answer.all(client,true)).to be_a(String)

	# 	end

	# end

	# context '#where' do

	# 	it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

	# 		expect(client).to be_an(OSCRuby::Client)

	# 		client = nil

	# 		expect{OSCRuby::Answer.where(client,'query')}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

	# 	end

	# 	it 'should raise an error if there is no query' do

	# 		expect{OSCRuby::Answer.where(client)}.to raise_error('A query must be specified when using the "where" method')

	# 	end

	# 	it 'should take a query and return results', :vcr do

	# 		products_lvl_1 = OSCRuby::Answer.where(client,"parent is null and lookupname not like 'Unsure'")

	# 		expect(products_lvl_1.count).to be > 0

	# 		products_lvl_1.each_with_index do |p,i|

	# 			if i < 10

	# 				expect(p).to be_an(OSCRuby::Answer)

	# 				# puts p.name

	# 			end

	# 		end

	# 	end

	# 	it 'should raise an error if the query returns 0 results', :vcr do

	# 		expect{OSCRuby::Answer.where(client,"parent = 6546546546546")}.to raise_error('There were no objects matching your query; please try again.')

	# 	end

	# 	it 'should just return JSON if the return_json parameter is set to true', :vcr do

	# 		parents = OSCRuby::Answer.where(client,"parent is null and lookupname not like 'Unsure'",true)

	# 		expect(parents).to be_a(String)

	# 		# puts parents

	# 	end

	# end

	# context '#update' do

	# 	it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not', :vcr do

	# 		known_working_product = OSCRuby::Answer.find(client, 100)

	# 		expect(client).to be_an(OSCRuby::Client)

	# 		client = nil

	# 		expect{known_working_product.update(client)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

	# 	end

	# 	it 'should expect that the Service Product is an instance of a OSCRuby::Answer', :vcr do

	# 		known_working_product = OSCRuby::Answer.find(client, 100)

	# 		expect(known_working_product).to be_an(OSCRuby::Answer)

	# 	end

	# 	it 'should expect that the product has an ID and spit out an error if it does not', :vcr do

	# 		known_working_product = OSCRuby::Answer.find(client, 100)

	# 		known_working_product.id = nil

	# 		expect{known_working_product.destroy(client)}.to raise_error('OSCRuby::Answer must have a valid ID set')
		
	# 	end

	# 	it 'should update name when the names is updated', :vcr do

	# 		test_prods = OSCRuby::Answer.where(client,"name like 'TEST-PRODUCT'")
	# 		first_prod = test_prods[0]

	# 		first_prod.names[0] = {"labelText" => "TEST-PRODUCT-UPDATED", "language" => {"id" => 1}}

	# 		first_prod.update(client)

	# 		expect(first_prod.name).to eq('TEST-PRODUCT-UPDATED')

	# 	end

	# 	it 'should just return JSON if the return_json parameter is set to true', :vcr do

	# 		known_working_product = OSCRuby::Answer.find(client, 100)

	# 		test = known_working_product.update(client,true)

	# 		expect(test).to be_a(String)

	# 	end

	# end

	# context '#destroy' do

	# 	it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not', :vcr do

	# 		test_prods = OSCRuby::Answer.where(client,"name like 'TEST-PRODUCT-UPDATED'")
	# 		product_to_delete = test_prods[0]

	# 		expect(client).to be_an(OSCRuby::Client)

	# 		client = nil

	# 		expect{product_to_delete.destroy(client)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

	# 	end

	# 	it 'should expect that the Service Product is an instance of a OSCRuby::Answer', :vcr do

	# 		test_prods = OSCRuby::Answer.where(client,"name like 'TEST-PRODUCT-UPDATED'")
	# 		product_to_delete = test_prods[0]

	# 		expect(product_to_delete).to be_an(OSCRuby::Answer)

	# 	end

	# 	it 'should expect that the product has an ID and spit out an error if it does not', :vcr do

	# 		test_prods = OSCRuby::Answer.where(client,"name like 'TEST-PRODUCT-UPDATED'")
	# 		product_to_delete = test_prods[0]

	# 		product_to_delete.id = nil

	# 		expect{product_to_delete.destroy(client)}.to raise_error('OSCRuby::Answer must have a valid ID set')
		
	# 	end

	# 	it 'should delete the product', :vcr do

	# 		test_prods = OSCRuby::Answer.where(client,"name like 'TEST-PRODUCT-UPDATED'")
	# 		product_to_delete = test_prods[0]

	# 		id_to_find = product_to_delete.id

	# 		product_to_delete.destroy(client)

	# 		expect{OSCRuby::Answer.find(client, id_to_find)}.to raise_error('There were no objects matching your query; please try again.')
		
	# 	end

	# end

end