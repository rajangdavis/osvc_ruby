# OSCRuby

[![Code Climate](https://codeclimate.com/github/rajangdavis/osc_ruby/badges/gpa.svg)](https://codeclimate.com/github/rajangdavis/osc_ruby) [![Test Coverage](https://codeclimate.com/github/rajangdavis/osc_ruby/badges/coverage.svg)](https://codeclimate.com/github/rajangdavis/osc_ruby/coverage) [![Build Status](https://travis-ci.org/rajangdavis/osc_ruby.svg?branch=master)](https://travis-ci.org/rajangdavis/osc_ruby) [![Gem Version](https://badge.fury.io/rb/osc_ruby.svg)](https://badge.fury.io/rb/osc_ruby)

An (under development) Ruby ORM for using Oracle Service Cloud influenced by the [ConnectPHP API](http://documentation.custhelp.com/euf/assets/devdocs/november2016/Connect_PHP/Default.htm) and ActiveRecord Gem


## Compatibility

This gem was tested against Oracle Service Cloud November 2016 using Ruby version 2.1.2p95 (2014-05-08 revision 45877) [x86_64-darwin13.0]. Additionally,
[TravisCI](https://travis-ci.org/rajangdavis/osc_ruby) tests against Ruby version 2.2.0 as well as jruby version 1.7.19

The create, update, and destroy methods should work on any version of Oracle Service Cloud since version May 2015; however, there maybe some issues with querying items on any version before May 2016. This is because ROQL queries were not exposed via the REST API until May 2016.

There is only support for except for ROQL Queries. There is still the capacity to create, read, update, and destroy a Service Cloud object; more on this below.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'osc_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install osc_ruby


## ServiceProduct Example
```ruby

# Configuration is as simple as requiring the gem

require 'osc_ruby'

rn_client = OSCRuby::Client.new do |config|
	config.username = ENV['OSC_ADMIN']
	config.password = ENV['OSC_PASSWORD']
	config.interface = ENV['OSC_SITE']
end

# use Ruby hashes and arrays to set field information

new_product = {}
new_product['names'] = []
new_product['names'][0] = {'labelText' => 'NEW_PRODUCT', 'language' => {'id' => 1}}
new_product['displayOrder'] = 4

new_product['adminVisibleInterfaces'] = []
new_product['adminVisibleInterfaces'][0] = {'id' => 1}
new_product['endUserVisibleInterfaces'] = []
new_product['endUserVisibleInterfaces'][0] = {'id' => 1}

res = OSCRuby::Connect.post_or_patch(rn_client,'/serviceProducts',new_product)

puts res.code # => 201

puts res.body # => JSON body

# callback with JSON details




# QueryResults example
# NOTE: Make sure to put your queries wrapped in doublequotes("")
# this is because when Ruby converts the queries into a URI
# the REST API does not like it when the queries are wrapped in single quotes ('')
# with strings escaped by double quotes

# For example
# "parent is null and lookupName!='Unsure'" => great!
# 'parent is null and lookupName!="Unsure"' => don't do this
# it will spit back an error from the REST API!

rn_client = OSCRuby::Client.new do |config|
	config.username = ENV['OSC_ADMIN']
	config.password = ENV['OSC_PASSWORD']
	config.interface = ENV['OSC_SITE']
end

q = OSCRuby::QueryResults.new

query = "select * from answers where ID = 1557"

results = q.query(rn_client,query) # => will return an array of results

puts results[0] => "{'id':1557,'name':...}"

```