require 'net/http'
require 'openssl'
require 'json'

require 'osc_ruby/version'
require 'osc_ruby/configuration'


module OSCRuby

	
	class Client
		# The top-level class that handles configuration and connection to the Oracle Service Cloud REST API.
		
		attr_accessor :config
		
		def initialize
	        raise ArgumentError, "block not given" unless block_given?
	        self.config ||= OSCRuby::Configuration.new
	    	yield(config)

	    	check_config
	    end

	    def check_config
	    	if config.interface ==''
	    		raise ArgumentError, "Interface cannot be nil or blank"
	    	elsif config.username ==''
	    		raise ArgumentError, "Username cannot be nil or blank"
	    	elsif config.password ==''
	    		raise ArgumentError, "Password cannot be nil or blank"	
	    	end
	    end

		def self.basic_auth_url
			uri = URI.parse(self.service_cloud_interface)
		end

	    def self.service_cloud_interface
	    	url = 'https://' + config.interface + '.custhelp.com/services/rest/connect/v1.3/'
	    end

	    def self.connect(config,uri)
	    	Net::HTTP.start(uri.host, uri.port,
				:use_ssl => true) do |http|

				request = Net::HTTP::Get.new uri.request_uri
				request.basic_auth config.username, config.password

				response = http.request request # Net::HTTPResponse object

				json_response = JSON.parse(response.body)
			end
	    end
	end
end