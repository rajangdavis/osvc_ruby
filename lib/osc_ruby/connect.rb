require 'osc_ruby/client'

require 'net/http'
require 'openssl'
require 'json'
require 'uri'

module OSCRuby
	
	class Connect
	   
	   	def self.get(client,url = nil)
			check_client_config(client)
		 #  	url = 'https://' + config.interface + '.custhelp.com/services/rest/connect/v1.3/'
		 #  	uri = URI.parse(url)

		 #  	Net::HTTP.start(uri.host, uri.port,
			# 	:use_ssl => true,
			# 	:verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

			# 	request = Net::HTTP::Get.new uri.request_uri
			# 	request.basic_auth config.username, config.password

			# 	response = http.request request # Net::HTTPResponse object

			# 	json_response = JSON.parse(response.body)
			# end
		end

		def self.check_client_config(client)

			if client.nil?
				raise ArgumentError, "Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings"
			else
				@config = client.config
			end

			if @config.nil?
				raise ArgumentError, "Client configuration cannot be nil or blank"	
			elsif @config.interface.nil?
				raise ArgumentError, "The configured client interface cannot be nil or blank"	
			elsif @config.username.nil?
				raise ArgumentError, "The configured client username cannot be nil or blank"	
			elsif @config.password.nil?
				raise ArgumentError, "The configured client password cannot be nil or blank"	
			end
		end

  	end
end