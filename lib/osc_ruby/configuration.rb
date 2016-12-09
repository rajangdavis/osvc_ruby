module OSCRuby
	class Configuration
		# takes config values for connecting to the REST API

		# @return [String] The basic auth username.
	    attr_accessor :username

	    # @return [String] The basic auth password.
	    attr_accessor :password

	    # @return [String] The site interface to connect to.
	    attr_accessor :interface

	    # @return [String] The resource that is being connected to .
	    attr_accessor :resource
	end
end