# OSCRuby

Still developing this; will let ya know when this happens.

The basic idea is to be able to do something simple like import a csv of information and post it into an Oracle Service Cloud site.

The ultimate goal is to use this gem to make a Rails app for advanced administration/development that cannot be done with Oracle Service Cloud alone

# TODO

	Figure out how to do RDoc/Yardoc documentation or best in class documentation for using this Ruby Wrapper

	Create a URL generator method into the Connect Class

	Move tests for the get method into the URL generator method

	Move check_config method into the URL generator method so that tests pass

	Create more tests to validate the generated URL

	Put the URL generator method into the get class

	Have the get method make a get request using the Net::HTTP class

	Need to add tests for passing resources, query/id/other param into the URL generator class

	Need to figure out how to pass resources and some sort of query/id/other param into the URL generator class

	Add in tests for Post requests

	Make a Post method

	Add in tests for update requests

	Make a update method

	Add in tests for delete requests

	Make a delete method

	Create a OSCRuby::ServiceProduct class

	Add in VCR and WebMock as dependencies

	Figure out how to record and stub responses for a good response and bad response

	Simulate these responses

	Add in TravisCI into workflow to run tests and push and publish gem

	Add in Code Climate? or something to show the percentage of covered methods for testing

	Follow with next Classes (ServiceCategories, Answers, Interfaces)

	Release MVP

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'osc_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install osc_ruby