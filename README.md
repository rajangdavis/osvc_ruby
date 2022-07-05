# OSvCRuby (Not Maintained)
 
[![Code Climate](https://codeclimate.com/github/rajangdavis/osvc_ruby/badges/gpa.svg)](https://codeclimate.com/github/rajangdavis/osvc_ruby) [![Test Coverage](https://api.codeclimate.com/v1/badges/202d9d688d31e18fcee2/test_coverage)](https://codeclimate.com/github/rajangdavis/osvc_ruby/test_coverage) [![Build Status](https://travis-ci.org/rajangdavis/osvc_ruby.svg?branch=master)](https://travis-ci.org/rajangdavis/osvc_ruby) [![Gem Version](https://badge.fury.io/rb/osvc_ruby.svg)](https://badge.fury.io/rb/osvc_ruby) [![Known Vulnerabilities](https://snyk.io/test/github/rajangdavis/osvc_ruby/badge.svg)](https://snyk.io/test/github/rajangdavis/osvc_ruby)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Frajangdavis%2Fosvc_ruby.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Frajangdavis%2Fosvc_ruby?ref=badge_shield)

An (under development) Ruby library for using the [Oracle Service Cloud REST API](https://docs.oracle.com/cloud/latest/servicecs_gs/CXSVC/) influenced by the [ConnectPHP API](http://documentation.custhelp.com/euf/assets/devdocs/november2016/Connect_PHP/Default.htm) and ActiveRecord Gem

## Installing Ruby (for Windows)
[Try this link.](https://rubyinstaller.org/downloads/).

I would highly recommend installing version 2.5 or newer for Windows. 

You will also need to install DevKit Tools which are located underneath the Ruby section

If you are using Windows 10, you can use your Linux Subsystem to work with Ruby; 

[here's instructions for how to do that.](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-and-set-up-a-local-programming-environment-on-windows-10)

If you get SSL Errors (you probably will), follow
[this link for instructions on resolving SSL things that I know nothing about](https://stackoverflow.com/a/16134586/2548452).

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'osvc_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install osvc_ruby
   
## Compatibility
This gem was tested against Oracle Service Cloud November 2016
using Ruby version 2.1.2p95 (2014-05-08 revision 45877) [x86_64-darwin13.0] between December 2016 and June 2017.

It is now being tested against Oracle Service Cloud May 2017 to 18A 
using Ruby version 2.5.0p0 (2017-12-25 revision 61468) [i386-mingw32]
using [TravisCI](https://travis-ci.org/rajangdavis/osvc_ruby) for continuous integration.

All of the HTTP methods should work on any version of Oracle Service Cloud since version May 2015;
however, there maybe some issues with querying items on any version before May 2016. This is because ROQL queries were not exposed via the REST API until May 2016.


## Use Cases
You can use this Ruby Library for basic scripting and microservices. The main features that work to date are as follows:

1. [Simple configuration](#client-configuration)
2. Running ROQL queries [either 1 at a time](#oscrubyqueryresults-example) or [multiple queries in a set](#oscrubyqueryresultsset-example)
3. [Running Reports with filters](#oscrubyanalyticsreportsresults)
<!-- 4. Convenience methods for Analytics filters and setting dates
	1. ['arrf', an analytics report results filter](#arrf--analytics-report-results-filter)
	2. ['dti', converts a date string to ISO8601 format](#dti--date-to-iso8601) -->
4. Basic CRUD Operations via HTTP Methods
	1. [Create => Post](#create)
	2. [Read => Get](#read)
	3. [Update => Patch](#update)
	4. [Destroy => Delete](#delete)



## Client Configuration

An OSvCRuby::Client object lets the library know which credentials and interface to use for interacting with the Oracle Service Cloud REST API.
This is helpful if you need to interact with multiple interfaces or set different headers for different objects.

```ruby

# Configuration is as simple as requiring the gem
# and writing a Ruby block

require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
	c.username = ENV['OSC_ADMIN']		# => These are interface credentials
	c.password = ENV['OSC_PASSWORD']	# => store these in environmental
	c.interface = ENV['OSC_SITE']		# => variables in your .bash_profile

	### optional configuration
	# Turns off SSL verification; don't use in production
	c.no_ssl_verify = true			# => Defaults to false. 
	
	# Sets the version of the REST API to use
	c.version = 'v1.4'			# => Defaults to 'v1.3'. 
	
	# Let's you supress business rules
	c.suppress_rules = true			# => Defaults to false. 
	
	# Use 'rightnowdemo' namespace instead of 'custhelp'
	c.demo_site = true			# => Defaults to false. 

end
```





## OSvCRuby::QueryResults example

This is for running one ROQL query. Whatever is allowed by the REST API (limits and sorting) is allowed with this library.

OSvCRuby::QueryResults only has one function: 'query', which takes an OSvCRuby::Client object and string query (example below).

```ruby
# NOTE: Make sure to put your queries WRAPPED in doublequotes("")
# this is because when Ruby converts the queries into a URI
# the REST API does not like it when the queries are WRAPPED in single quotes ('')

# For example
# "parent is null and lookupName!='Unsure'" => great!
# 'parent is null and lookupName!="Unsure"' => don't do this
# it will spit back an error from the REST API!

require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
	c.username = ENV['OSC_ADMIN']
	c.password = ENV['OSC_PASSWORD']
	c.interface = ENV['OSC_SITE']	
end

q = OSvCRuby::QueryResults.new

query = "select * from answers where ID = 1557"

results = q.query(rn_client,query) # => will return an array of results

puts results[0] # => "{'id':1557,'name':...}"

```











## OSvCRuby::QueryResultsSet example

This is for running multiple queries and assigning the results of each query to a key for further manipulation.

OSvCRuby::QueryResultsSet only has one function: 'query_set', which takes an OSvCRuby::Client object and multiple query hashes (example below).

```ruby
# NOTE: Make sure to put your queries WRAPPED in doublequotes("")
# Pass in each query into a hash
	# set query: to the query you want to execute
	# set key: to the value you want the results to of the query to be referenced to

require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
	c.username = ENV['OSC_ADMIN']
	c.password = ENV['OSC_PASSWORD']
	c.interface = ENV['OSC_SITE']	
end

mq = OSvCRuby::QueryResultsSet.new
r = mq.query_set(rn_client,
		 	{query:"DESCRIBE ANSWERS", key: "answerSchema"},
		 	{query:"SELECT * FROM ANSWERS LIMIT 1", key: "answers"},
		 	{query:"DESCRIBE SERVICECATEGORIES", key: "categoriesSchema"},
		 	{query:"SELECT * FROM SERVICECATEGORIES", key:"categories"},
		 	{query:"DESCRIBE SERVICEPRODUCTS", key: "productsSchema"},
		 	{query:"SELECT * FROM SERVICEPRODUCTS", key:"products"})

puts JSON.pretty_generate(r.answerSchema)

# Results for "DESCRIBE ANSWERS"
#
# [
#  {
#    "Name": "id",
#    "Type": "Integer",
#    "Path": ""
#  },
#  {
#    "Name": "lookupName",
#    "Type": "String",
#    "Path": ""
#  },
#  {
#    "Name": "createdTime",
#    "Type": "String",
#    "Path": ""
#  }
#  ... everything else including customfields and objects...
#]

puts JSON.pretty_generate(r.answers)

# Results for "SELECT * FROM ANSWERS LIMIT 1"
#
# [
#  {
#    "id": 1,
#    "lookupName": 1,
#    "createdTime": "2016-03-04T18:25:50Z",
#    "updatedTime": "2016-09-12T17:12:14Z",
#    "accessLevels": 1,
#    "adminLastAccessTime": "2016-03-04T18:25:50Z",
#    "answerType": 1,
#    "expiresDate": null,
#    "guidedAssistance": null,
#    "keywords": null,
#    "language": 1,
#    "lastAccessTime": "2016-03-04T18:25:50Z",
#    "lastNotificationTime": null,
#    "name": 1,
#    "nextNotificationTime": null,
#    "originalReferenceNumber": null,
#    "positionInList": 1,
#    "publishOnDate": null,
#    "question": null,
#    "solution": "<HTML SOLUTION WITH INLINE CSS>",
#    "summary": "SPRING IS ALMOST HERE!",
#    "updatedByAccount": 16,
#    "uRL": null
#  }
#]

puts JSON.pretty_generate(r.categoriesSchema)

# Results for "DESCRIBE SERVICECATEGORIES"
# 
#[
#... skipping the first few ... 
# {
#    "Name": "adminVisibleInterfaces",
#    "Type": "SubTable",
#    "Path": "serviceCategories.adminVisibleInterfaces"
#  },
#  {
#    "Name": "descriptions",
#    "Type": "SubTable",
#    "Path": "serviceCategories.descriptions"
#  },
#  {
#    "Name": "displayOrder",
#    "Type": "Integer",
#    "Path": ""
#  },
#  {
#    "Name": "endUserVisibleInterfaces",
#    "Type": "SubTable",
#    "Path": "serviceCategories.endUserVisibleInterfaces"
#  },
#  ... everything else include parents and children ...
#]

puts JSON.pretty_generate(r.categories)

# Results for "SELECT * FROM SERVICECATEGORIES"
#
# [
#  {
#    "id": 3,
#    "lookupName": "Manuals",
#    "createdTime": null,
#    "updatedTime": null,
#    "displayOrder": 3,
#    "name": "Manuals",
#    "parent": 60
#  },
#  {
#    "id": 4,
#    "lookupName": "Installations",
#    "createdTime": null,
#    "updatedTime": null,
#    "displayOrder": 4,
#    "name": "Installations",
#    "parent": 60
#  },
#  {
#    "id": 5,
#    "lookupName": "Downloads",
#    "createdTime": null,
#    "updatedTime": null,
#    "displayOrder": 2,
#    "name": "Downloads",
#    "parent": 60
#  },
#  ... you should get the idea by now ...
#]

### Both of these are similar to the above
puts JSON.pretty_generate(r.productsSchema) # => Results for "DESCRIBE SERVICEPRODUCTS"
puts JSON.pretty_generate(r.products) # => Results for "SELECT * FROM SERVICEPRODUCTS"

```







## OSvCRuby::AnalyticsReportsResults

You can create a new instance either by the report 'id' or 'lookupName'.

OSvCRuby::AnalyticsReportsResults only has one function: 'run', which takes an OSvCRuby::Client object.

OSvCRuby::AnalyticsReportsResults have the following properties: 'id', 'lookupName', and 'filters'. More on filters and supported datetime methods are below this OSvCRuby::AnalyticsReportsResults example script.

```ruby
require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
	c.username = ENV['OSC_ADMIN']
	c.password = ENV['OSC_PASSWORD']
	c.interface = ENV['OSC_SITE']	
end

last_updated = OSvCRuby::AnalyticsReportResults.new(lookupName: "Last Updated By Status")

puts last_updated.run(rn_client)

#{"Status"=>"Unresolved", "Incidents"=>704, "Average Time Since Last Response"=>"39029690.149123"}
#{"Status"=>"Updated", "Incidents"=>461, "Average Time Since Last Response"=>"39267070.331683"}

```










<!-- ## Convenience Methods

### 'arrf' => analytics report results filter

'arrf' lets you set filters for an OSvCRuby::AnalyticsReportsResults Object.

You can set the following keys:
1. name => The filter name
2. prompt => The prompt for this filter

These are under development, but these should work if you treat them like the the data-type they are as mentioned in the REST API:

3. [attributes](https://docs.oracle.com/cloud/latest/servicecs_gs/CXSVC/op-services-rest-connect-v1.4-analyticsReportResults-post.html#request-definitions-namedIDs-analyticsReports-filters-attributes)
4. [dataType](https://docs.oracle.com/cloud/latest/servicecs_gs/CXSVC/op-services-rest-connect-v1.4-analyticsReportResults-post.html#request-definitions-namedIDs-analyticsReports-filters-dataType)
5. [operator](https://docs.oracle.com/cloud/latest/servicecs_gs/CXSVC/op-services-rest-connect-v1.4-analyticsReportResults-post.html#request-definitions-namedIDs-analyticsReports-filters-operator)
6. [values](https://docs.oracle.com/cloud/latest/servicecs_gs/CXSVC/op-services-rest-connect-v1.4-analyticsReportResults-post.html#request-namedIDs-definitions-analyticsReports-filters-values)

```ruby
require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
	c.username = ENV['OSC_ADMIN']
	c.password = ENV['OSC_PASSWORD']
	c.interface = ENV['OSC_SITE']	
end

answers_search = OSvCRuby::AnalyticsReportResults.new(id: 176)

keywords = arrf(name: "search_ex", values: "Maestro")
answers_search.filters << keywords

# To add more filters, create another 
# "arrf" filter structure
# and "shovel" it into 
# the OSvCRuby::AnalyticsReportResults
# "filters" property
#
# date_created = arrf(name: "date_created", values: dti("August 7th, 2017"))
# answers_search.filters << date_created


answers = answers_search.run(rn_client)		

answers.each do |answer|
	puts answer['Summary']
end			

# =>

# How do I get started with the Maestro Smart Thermostat App?

# Is my Wi-Fi router compatible with the Maestro Smart Thermostat?

# Will the Maestro Smart Thermostat work with my HVAC system?

# Maestro Smart Thermostat App

# Maestro Smart Thermostat Installation Guide

# Maestro Product Warranty

# ... and so on and so forth
```

 -->



<!-- 

### 'dti' => date to iso8601

dti lets you type in a date and get it in ISO8601 format. Explicit date formatting is best.

```ruby

dti("January 1st, 2014") # => 2014-01-01T00:00:00-08:00  # => 1200 AM, January First of 2014

dti("January 1st, 2014 11:59PM MDT") # => 2014-01-01T23:59:00-06:00 # => 11:59 PM Mountain Time, January First of 2014

dti("January 1st, 2014 23:59 PDT") # => 2014-01-01T23:59:00-07:00 # => 11:59 PM Pacific Time, January First of 2014

dti("January 1st") # => 2017-01-01T00:00:00-08:00 # => 12:00 AM, January First of this Year

```


Be careful! Sometimes the dates will not be what you expect; try to write dates as explicitly/predictably when possible.


```ruby

# EXAMPLES OF DATES NOT BEING WHAT YOU MIGHT EXPECT

#Full dates should be formatted as 
# %d/%m/%y %h:%m tt

dti("01/02/14") # => 2001-02-14T00:00:00-08:00 # => 12:00 AM, February 14th, 2001

dti("01/02/2014") # => 2014-02-01T00:00:00-08:00 # => 12:00 AM, February 14th, 2014

dti("11:59PM January 1st, 2014 GMT") #=> 2017-08-01T23:59:00-07:00 #=> 11:59 PM, August 1st, 2017 Pacific Time (?)

```


 -->






## Basic CRUD operations

### CREATE
```ruby
#### OSvCRuby::Connect.post( <client>, <url>, <json_data> )
#### returns a NetHTTPRequest object

# Here's how you could create a new ServiceProduct object
# using Ruby variables, hashes(sort of like JSON), and arrays to set field information

require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
	c.username = ENV['OSC_ADMIN']
	c.password = ENV['OSC_PASSWORD']
	c.interface = ENV['OSC_SITE']	
end

new_product = {}
new_product['names'] = []
new_product['names'][0] = {'labelText' => 'NEW_PRODUCT', 'language' => {'id' => 1}}
new_product['displayOrder'] = 4

new_product['adminVisibleInterfaces'] = []
new_product['adminVisibleInterfaces'][0] = {'id' => 1}
new_product['endUserVisibleInterfaces'] = []
new_product['endUserVisibleInterfaces'][0] = {'id' => 1}

res = OSvCRuby::Connect.post(rn_client,'/serviceProducts',new_product)

puts res.code # => 201

puts res.body # => JSON body

# callback with JSON details

```






### READ
```ruby
#### OSvCRuby::Connect.get( <client>, optional (<url>/<id>/...<params>) )
#### returns a NetHTTPRequest object
# Here's how you could get a list of ServiceProducts

require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
	c.username = ENV['OSC_ADMIN']
	c.password = ENV['OSC_PASSWORD']
	c.interface = ENV['OSC_SITE']	
end

res = OSvCRuby::Connect.get(rn_client,'/serviceProducts?limit=3')

puts JSON.pretty_generate(res.body)

#{
#    "items": [
#        {
#            "id": 2,
#            "lookupName": "Maestro Smart Thermostat",
#            "links": [
#                {
#                    "rel": "canonical",
#                    "href": "https://<OSC_SITE>.rightnowdemo.com/services/rest/connect/v1.3/serviceProducts/2"
#                }
#            ]
#        },
#        {
#            "id": 6,
#            "lookupName": "Home Security",
#            "links": [
#                {
#                    "rel": "canonical",
#                    "href": "https://<OSC_SITE>.rightnowdemo.com/services/rest/connect/v1.3/serviceProducts/6"
#                }
#            ]
#        },
#        {
#            "id": 7,
#            "lookupName": "Hubs",
#            "links": [
#                {
#                    "rel": "canonical",
#                    "href": "https://<OSC_SITE>.rightnowdemo.com/services/rest/connect/v1.3/serviceProducts/7"
#                }
#            ]
#        }
#    ],
#    "hasMore": true,
#
#	 ... and everything else ... 
#	
#}
```






### UPDATE
```ruby
#### OSvCRuby::Connect.patch( <client>, <url>, <json_data> )
#### returns a NetHTTPRequest object
# Here's how you could update the previously created ServiceProduct object
# using Ruby variables, arrays, hashes, 
# and symbols (read only string values, eg :example)
# to set field information

require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
	c.username = ENV['OSC_ADMIN']
	c.password = ENV['OSC_PASSWORD']
	c.interface = ENV['OSC_SITE']	
end


names = []

names[0] = {:labelText => 'PRODUCT-TEST-updated', :language => {:id => 1}}
displayOrder = {:id => 4}

admin_user_visible_interfaces = []
admin_user_visible_interfaces[0] = {:id => 1}

end_user_visible_interfaces = []
end_user_visible_interfaces[0] = {:id => 1}

prod_info_to_change = []
prod_info_to_change[0] = {:names => names, 
			              :adminVisibleInterfaces => admin_user_visible_interfaces,
			              :endUserVisibleInterfaces => end_user_visible_interfaces}

updated_product = OSvCRuby::Connect.patch(rn_client,"serviceProducts/56",prod_info_to_change[0]) 

puts updated_product.code # => "200"

puts updated_product.body # => "" if successful...

```






### DELETE
```ruby
#### OSvCRuby::Connect.delete( <client>, <url> )
#### returns a NetHTTPRequest object
# Here's how you could delete the previously updated ServiceProduct object
# using the OSvCRuby::QueryResults 
# and OSvCRuby::Connect classes

require 'osvc_ruby'

rn_client = OSvCRuby::Client.new do |c|
	c.username = ENV['OSC_ADMIN']
	c.password = ENV['OSC_PASSWORD']
	c.interface = ENV['OSC_SITE']	
end

q = OSvCRuby::QueryResults.new
query = "select id from serviceproducts where lookupname = 'PRODUCT-TEST-updated';"

product_test_updated = q.query(rn_client,resource) # => returns array of results

test = OSvCRuby::Connect.delete(rn_client,"serviceProducts/#{product_test_updated[0]['id']}")

puts updated_product.code # => "200"

puts updated_product.body # => "" if successful...


```

## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Frajangdavis%2Fosvc_ruby.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Frajangdavis%2Fosvc_ruby?ref=badge_large)
