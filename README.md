# OSCRuby

[![Code Climate](https://codeclimate.com/github/rajangdavis/osc_ruby/badges/gpa.svg)](https://codeclimate.com/github/rajangdavis/osc_ruby) [![Test Coverage](https://codeclimate.com/github/rajangdavis/osc_ruby/badges/coverage.svg)](https://codeclimate.com/github/rajangdavis/osc_ruby/coverage) [![Build Status](https://travis-ci.org/rajangdavis/osc_ruby.svg?branch=master)](https://travis-ci.org/rajangdavis/osc_ruby) [![Gem Version](https://badge.fury.io/rb/osc_ruby.svg)](https://badge.fury.io/rb/osc_ruby)

An (under development) Ruby ORM for using Oracle Service Cloud influenced by the [ConnectPHP API](http://documentation.custhelp.com/euf/assets/devdocs/november2016/Connect_PHP/Default.htm) and ActiveRecord Gem

## Example (still coding this out, but trying to get this pretty simple)
```ruby
	# Configuration is as simple as requiring the gem
	# and adding a config block (Completed 12/2016)

	require 'osc_ruby'

	rn_client = OSCRuby::Client.new do |config|
		config.username = ENV['OSC_ADMIN']
		config.password = ENV['OSC_PASSWORD']
		config.interface = ENV['OSC_TEST_SITE']
	end


	# ServiceProduct Creation example (Completed 12/30/2016)

	new_product = OSCRuby::ServiceProduct.new

	# use Ruby hashes to set field information

	new_product.names[0] = {'labelText' => 'QTH45-test', 'language' => {'id' => 1}}
	new_product.names[1] = {'labelText' => 'QTH45-test', 'language' => {'id' => 11}}

	new_product.parent = {'id' => 102}

	new_product.displayOrder = 4

	new_product.adminVisibleInterfaces[0] = {'id' => 1}

	new_product.endUserVisibleInterfaces[0] = {'id' => 1}

	new_product.create(rn_client)

	# callback with JSON details




	# NOTE: Make sure that in a production environment
	# that the following methods are wrapped in a begin/rescue block.

	# If a null set is returned by your query
	# an exception will be raised
	# this is to ensure that you 
	# handle your errors explicitly
	# when writing scripts


	# ServiceProduct fetch example (Completed 12/28/2016)

	product = OSCRuby::ServiceProduct.find(rn_client,100)

	puts product
	# => #<ServiceProduct:0x007fd0fa87e588>

	puts product.name
	# => QR404

	puts product.displayOrder
	# => 3

	# ServiceProduct fetch all example (Completed 01/05/2017)

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


	# ServiceProduct where example (Completed 01/05/2017) 

	# NOTE: Make sure to put your queries wrapped in doublequotes("")
	# this is because when Ruby converts the queries into a URI
	# the REST API does not like it when the queries are wrapped in single quotes ('')
	# with strings escaped by double quotes

	# For example
	# "parent is null and lookupName!='Unsure'" => great!
	# 'parent is null and lookupName!="Unsure"' => don't do this
	# it will spit back an error from the REST API!

	products_lvl_1 = OSCRuby::ServiceProduct.where(rn_client,"parent is null and lookupName!='Unsure'")

	products_lvl_1.each do |p|

		puts p.name

	end

	# => DVR/NVR
	# => Cameras
	# => Accessories


	# ServiceProduct update example (Completed 01/05/2017)

	product_to_update = OSCRuby::ServiceProduct.find(rn_client,100)

	product_to_update.names[0] = {'labelText' => 'name-updated', 'language' => {'id' => 1}}

	product_to_update.update(rn_client)

	# ServiceProduct updated




	# ServiceProduct destroy example (Completed 01/06/2017)

	product_to_delete = OSCRuby::ServiceProduct.find(rn_client,100)

	product_to_delete.destroy(rn_client)

	# ServiceProduct destroyed
```

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

- [x] Build a QueryModule Module with the following query methods to be shared between most if not all classes:

- [x] create, find, where, all, update, destroy

- [x] QueryModule converts JSON response into a Ruby Hash => new instance of the object being queried

- [x] Create some validations for creating a ServiceProduct object

- [x] Add in VCR and WebMock as dependencies

- [x] Figure out how to record and stub responses for a good response and bad response

- [x] Simulate these responses for ALL Connect HTTP methods

- [ ] Make OpenSSL::SSL::VERIFY_PEER the default with OpenSSL::SSL::VERIFY_NONE option set in the config class 

- [ ] Make version default to 1.3 but an option to be set in the config class

- [ ] Allow for the prefer:exclude-null-properties header => update config and connect class, update tests

- [ ] Allow for Session Authorization => update config class and connect classes, update tests

- [ ] Figure out how to do RDoc/Yardoc documentation or best in class documentation for using this Ruby ORM

- [ ] Follow with next Classes (ServiceCategories, Answers, Incidents)

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