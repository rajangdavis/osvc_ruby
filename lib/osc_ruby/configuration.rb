module OSCRuby
	class Configuration
	
	    attr_accessor :interface,:username,:password,:resource

	    def initialize
	    	@resource = ''
	    end
	end
end