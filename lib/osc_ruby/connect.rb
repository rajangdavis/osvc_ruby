require 'osc_ruby/client'

require 'net/http'
require 'openssl'
require 'uri'
require 'cgi'

module OSCRuby
	
	class Connect
		# This class is purely to provide the underlying methods for CRUD functionality using Net::HTTP, URI, and OpenSSL

		def self.get(client,resource_url = nil)

			@final_config = get_check(client,resource_url)

			@uri = @final_config['site_url']

			@username = @final_config['username']
			@password = @final_config['password']

			Net::HTTP.start(@uri.host, @uri.port,
				:use_ssl => true,
				:verify_mode => @final_config['ssl']) do |http|

				request = Net::HTTP::Get.new @uri.request_uri

				request.add_field('Content-Type', 'application/x-www-form-urlencoded')
				if @final_config['suppress_rules'] == true
					request.add_field 'OSvC-CREST-Suppress-All',true
				end

				request.basic_auth @username, @password

				http.request request # Net::HTTPResponse object

			end

		end

		def self.post_or_patch(client,resource_url = nil, json_content = nil,patch_request = false)

			@final_config = post_and_patch_check(client,resource_url, json_content, patch_request)

			@uri = @final_config['site_url']
			@username = @final_config['username']
			@password = @final_config['password']

			Net::HTTP.start(@uri.host, @uri.port,
				:use_ssl => true, 
				:verify_mode => @final_config['ssl']) do |http|

				request = Net::HTTP::Post.new @uri.request_uri
				request.basic_auth @username, @password
				request.content_type = "application/json"
				if @final_config['patch_request'] == true
					request.add_field 'X-HTTP-Method-Override','PATCH'
				end
				if @final_config['suppress_rules'] == true
					request.add_field 'OSvC-CREST-Suppress-All',true
				end
				request.body = JSON.dump(json_content)

				http.request request # Net::HTTPResponse object

			end

		end

		def self.delete(client,resource_url = nil)

			@final_config = delete_check(client,resource_url)

			@uri = @final_config['site_url']
			@username = @final_config['username']
			@password = @final_config['password']

			Net::HTTP.start(@uri.host, @uri.port,
			  :use_ssl => true, 
			  :verify_mode => @final_config['ssl']) do |http|

			  request = Net::HTTP::Delete.new @uri.request_uri
			  request.basic_auth @username, @password

			  http.request request # Net::HTTPResponse object

			end
		
		end


		## checking methods

		def self.generate_url_and_config(client,resource_url = nil, patch_request = false)

			check_client_config(client)

			@config = client.config

			@version = @config.version

			@ssl_verification = ssl_check(@config)

			@rule_suppression = rule_suppress_check(@config)

		  	@url = "https://" + @config.interface + ".custhelp.com/services/rest/connect/#{@version}/#{resource_url}"
		  	
		  	@final_uri = URI(@url)

		  	@patch_request = patch_request == true ? true : false
		  	
		  	@final_config = {'site_url' => @final_uri,
		  					 'username' => @config.username, 
		  					 'password' => @config.password, 
		  					 'patch_request' => @patch_request, 
		  					 'ssl' => @ssl_verification, 
		  					 'suppress_rules' => @rule_suppression
		  					}

		end

		def self.rule_suppress_check(config)

			if config.suppress_rules == true || config.suppress_rules == "Yes"

				true
				
			else
				
				false

			end

		end

		def self.ssl_check(config)

			if config.no_ssl_verify == true

				OpenSSL::SSL::VERIFY_NONE
				
			else
				
				OpenSSL::SSL::VERIFY_PEER

			end

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

		def self.get_check(client,resource_url = nil)

			if client.nil?
				raise ArgumentError, "Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings"
			elsif !resource_url.nil?
				@final_config = generate_url_and_config(client,resource_url)
			else
				@final_config = generate_url_and_config(client,nil)
			end

		end

		def self.post_and_patch_check(client,resource_url = nil, json_content = nil, patch_request = false)

			if client.nil?
				raise ArgumentError, "Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings"
			elsif resource_url.nil?
				raise ArgumentError, "There is no URL resource provided; please specify a URL resource that you would like to send a POST or PATCH request to"
			elsif json_content.nil?
				raise ArgumentError, "There is no json content provided; please specify json content that you would like to send a POST or PATCH request with"
			elsif patch_request == true
				@final_config = generate_url_and_config(client,resource_url,true)
			else
				@final_config = generate_url_and_config(client,resource_url)
			end

		end

		def self.delete_check(client,resource_url = nil)
			if client.nil?
				raise ArgumentError, "Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings"
			elsif resource_url.nil?
				raise ArgumentError, "There is no URL resource provided; please specify a URL resource that you would like to send a POST or PATCH request to"
			else
				@final_config = generate_url_and_config(client,resource_url)
			end
		end

	end

end