module OSCRuby

	class Configuration
		# A holder class that holds the configuration information for the OSCRuby::Client block
	
	    attr_accessor :interface,:username,:password,:no_ssl_verify,:version

	    def initialize
	    	@no_ssl_verify = false
	    	@version = 'v1.3'
	    end
	end
end