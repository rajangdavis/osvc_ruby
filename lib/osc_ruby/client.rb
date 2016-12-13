require 'net/http'
require 'openssl'

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

		# def basic_auth(config)
		# 	uri = URI(service_cloud_interface(config))
		# end

	 #    def service_cloud_interface(config)
	 #    	@url = 'https://' + config.interface + '/services/rest/connect/v1.3/'
	 #    end

	 #    def connect(config,uri)
	 #    	Net::HTTP.start(uri.host, uri.port,
		# 	  :use_ssl => uri.scheme == 'https') do |http|

		# 	  request = Net::HTTP::Get.new uri.request_uri
		# 	  request.basic_auth config.username, config.password

		# 	  response = http.request request # Net::HTTPResponse object

		# 	  puts response
		# 	  puts response.body
		# 	end
	 #    end
	end
end