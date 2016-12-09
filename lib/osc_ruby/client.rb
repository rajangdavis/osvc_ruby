require 'net/http'

require 'osc_ruby/version'
require 'osc_ruby/configuration'

module OSCRuby
	
	class Client
	# The top-level class that handles configuration and connection to the Oracle Service Cloud REST API.

		def initialize
	        raise ArgumentError, "block not given" unless block_given?

	        @config = OSCRuby::Configuration.new
	        yield config

	    end

		def basic_auth(config)
			uri = URI(service_cloud_interface(config))
		end

	    def service_cloud_interface(config)
	    	@url = 'https://' + config.interface + '/services/rest/connect/v1.3/'
	    end
  
	end
end