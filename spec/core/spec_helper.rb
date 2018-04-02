require 'osvc_ruby'
require 'simplecov'
require 'vcr'
require 'json'

VCR.configure do |c|
	c.cassette_library_dir = "spec/fixtures"
	c.hook_into :webmock
	c.allow_http_connections_when_no_cassette = true
	c.filter_sensitive_data('<OSC_ADMIN_USERNAME>') { ENV['OSC_ADMIN'] }
	c.filter_sensitive_data('<OSC_ADMIN_PASSWORD>') { ENV['OSC_PASSWORD'] }
	c.filter_sensitive_data('<TEST_INTERFACE>') { ENV['OSC_SITE'] }
	c.filter_sensitive_data('<BASIC_AUTH>') { ENV['OSC_BASIC_64'] } 
end

RSpec.configure do |c|
  c.around(:each, :vcr) do |example|
    class_name = example.metadata[:described_class].to_s.gsub(/OSvCRuby::/,'').downcase
    method_name = example.metadata[:example_group][:description_args][0].gsub(/#/,'')
    test_name = example.metadata[:description].gsub(/ /,'_').downcase
    name = [class_name,method_name,test_name].join('/')[0...95]
    VCR.use_cassette(name) { example.call }
  end
end

SimpleCov.start