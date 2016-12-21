require 'osc_ruby/client'

require 'net/http'
require 'openssl'
require 'json'
require 'uri'

module OSCRuby
	
	class Connect

		def self.get(client,resource_url = nil)

			if client.nil?
				raise ArgumentError, "Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings"
			else
				@final_config = generate_url_and_config(client)
			end

			@uri = @final_config['site_url']
			@username = @final_config['username']
			@password = @final_config['password']

			Net::HTTP.start(@uri.host, @uri.port,
				:use_ssl => true,
				:verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

				request = Net::HTTP::Get.new @uri.request_uri
				request.basic_auth @username, @password

				response = http.request request # Net::HTTPResponse object
			end
		end

		private

		def self.generate_url_and_config(client,resource_url = nil)

			check_client_config(client)

			@config = client.config

		  	@url = "https://" + @config.interface + ".custhelp.com/services/rest/connect/v1.3/#{resource_url}"
		  	
		  	@final_uri = URI(@url)
		  	
		  	@final_config = {'site_url' => @final_uri, 'username' => @config.username, 'password' => @config.password}

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