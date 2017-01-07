require 'osc_ruby'
require 'simplecov'
require 'vcr'
require 'json'

VCR.configure do |c|
	c.cassette_library_dir = "spec/fixtures"
	c.hook_into :fakeweb
	c.allow_http_connections_when_no_cassette = true
	c.filter_sensitive_data('<OSC_ADMIN_USERNAME>') { ENV['OSC_ADMIN'] }
	c.filter_sensitive_data('<OSC_ADMIN_PASSWORD>') { ENV['OSC_PASSWORD'] }
	c.filter_sensitive_data('<TEST_INTERFACE>') { ENV['OSC_TEST_SITE'] }
	c.filter_sensitive_data('<BASIC_AUTH>') { ENV['OSC_BASIC_64'] } 
end

RSpec.configure do |c|
  c.around(:each, :vcr) do |example|
    class_name = example.metadata[:described_class].to_s.gsub(/OSCRuby::/,'').downcase
    method_name = example.metadata[:example_group][:description_args][0].gsub(/#/,'')
    test_name = example.metadata[:description].gsub(/ /,'_').downcase
    name = [class_name,method_name,test_name].join('/')
    VCR.use_cassette(name) { example.call }
  end
end

SimpleCov.start