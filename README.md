# OSCRuby

[![Code Climate](https://codeclimate.com/github/rajangdavis/osc_ruby/badges/gpa.svg)](https://codeclimate.com/github/rajangdavis/osc_ruby)

[![Test Coverage](https://codeclimate.com/github/rajangdavis/osc_ruby/badges/coverage.svg)](https://codeclimate.com/github/rajangdavis/osc_ruby/coverage)



An (under development) Ruby ORM for using Oracle Service Cloud influenced by the ConnectPHP API and ActiveRecord Gem

## Example (still coding this out, but trying to get this pretty simple)

	# Configuration is as simple as requiring the gem
	# and adding a config block (Completed 12/2016)

	require 'osc_ruby'

	rn_client = OSCRuby::Client.new do |config|
		config.username = ENV['OSC_ADMIN']
		config.password = ENV['OSC_PASSWORD']
		config.interface = ENV['OSC_TEST_SITE']
	end


	# ServiceProduct fetch example (Completed 12/28/2016)

		product = ServiceProduct.find(rn_client,100)

		puts product
		# => #<ServiceProduct:0x007fd0fa87e588>

		puts product.name
		# => QR404

		puts product.displayOrder
		# => 3

	# ServiceProduct fetch all example

		products = OSCRuby::ServiceProduct.all(rn_client)

		products.each do |p|

			puts p.name

		end

		# => Unsure
		# => DVR/NVR
		# => QC Series
		# => QR Series
		# => QR404
		# => QS Series
		# => QT Series

	# Product Creation example

		new_product = OSCRuby::ServiceProduct.new

		# use Ruby hashes to set field information

		new_product.names[0] = {'labelText' => 'QTH45-test', 'language' => {'id' => 1}}
		new_product.names[1] = {'labelText' => 'QTH45-test', 'language' => {'id' => 11}}

		new_product.parent = {'id' => 102}

		new_product.displayOrder = 4

		new_product.adminVisibleInterfaces[0] = {'id' => 1}

		new_product.endUserVisibleInterfaces[0] = {'id' => 1}

		new_product.save(client)

	# callback with JSON details


## To do list

- [x] Create a URL generator method into the Connect Class

- [x] Move tests for the get method into the URL generator method

- [x] Move check_config method into the URL generator method so that tests pass

- [x] Create more tests to validate the generated URL

- [x] Add in TravisCI into workflow to run tests and push and publish gem

- [x] Add in Code Climate or something to show the percentage of covered methods for testing

- [x] Put the URL generator method into the get class

- [x] Have the get method make a get request using the Net::HTTP class

- [x] Need to add tests for passing resources, query/id/other param into the URL generator class

- [x] Need to figure out how to pass resources and some sort of query/id/other param into the URL generator class

- [x] Add in tests for Post requests

- [x] Make a Post method

- [x] Add in tests for patch requests

- [x] Make a patch method

- [x] Add in tests for delete requests

- [x] Make a delete method

- [x] Create a OSCRuby::ServiceProduct class

- [x] Build a QueryModule Module with the following query methods to be shared between all classes:
	
- [x] find
	
- [ ] take
	
- [ ] first
	
- [ ] last
	
- [ ] order
	
- [ ] find_by
	
- [ ] where
	
- [ ] all

- [x] QueryModel converts JSON response into a Ruby Hash => new instance of the object being queried

- [ ] Figure out how to do RDoc/Yardoc documentation or best in class documentation for using this Ruby Wrapper

- [ ] Add in VCR and WebMock as dependencies

- [ ] Figure out how to record and stub responses for a good response and bad response

- [ ] Simulate these responses

- [ ] Follow with next Classes (ServiceCategories, Answers, Interfaces)

- [ ] Release MVP

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'osc_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install osc_ruby