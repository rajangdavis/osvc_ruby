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

	    	true
	    end
	end
end