require 'osc_ruby/client'

require 'net/http'
require 'openssl'
require 'json'
require 'uri'

module OSCRuby
	class Connect
	   
	   	def get(client,url)
			check_client(client)
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

		def check_client(client)
			if client.nil?
				raise ArgumentError, "Client cannot be nil or blank"	
			end
		end

  	end
end