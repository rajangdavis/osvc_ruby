require "osc_ruby/version"

class OSCRuby
  def username(str)
  	if str.nil?
    	raise 'OSCRuby.username cannot be nil'
    elsif str.length == 0
    	raise 'OSCRuby.username must have a length greater than zero'
    else
    	str
	end
  end

  def password(str)
    if str.nil?
    	raise 'OSCRuby.password cannot be nil'
    elsif str.length == 0
    	raise 'OSCRuby.password must have a length greater than zero'
    else
    	str
	end
  end
  
  def interface(str)
    if str.nil?
    	raise 'OSCRuby.interface cannot be nil'
    elsif str.length == 0
    	raise 'OSCRuby.interface must have a length greater than zero'
    else
    	str
	end
  end
end
