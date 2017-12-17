require 'osc_ruby/connect'
require 'json'

module OSCRuby

	module ValidationsModule

		class << self

		    def check_query(query,method_name = "where")

				if query.empty?
					
					raise ArgumentError, "A query must be specified when using the '#{method_name}' method"

				end

		    end

			def check_client(client)

				if client.class != OSCRuby::Client || client.nil?

					raise ArgumentError, "Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings"

				end
				client
			end

		end

	end
	
end