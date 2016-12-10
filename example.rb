# Client class to initiate generic requests

# => hosts Net::HTTP Class
# => returns the response

  # => CREATE

    # => POST to end point

  # => READ
    # => SHOW Example
    # Net::HTTP.start(uri.host, uri.port,
    #   :use_ssl => uri.scheme == 'https', 
    #   :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

    #   request = Net::HTTP::Get.new uri.request_uri
    #   request.basic_auth username, password

    #   response = http.request request # Net::HTTPResponse object

    #   json_response = JSON.parse(response.body)

    # end

# Configuration class to collect client values
  # => username
  # => password  
  # => interface

# ServiceProduct class
# SiteInterface class

require 'net/http'
require 'openssl'
require 'json'
require 'uri'

interface = 'qsee--tst1' 
username = ENV['OSC_ADMIN'] 
password = ENV['OSC_PASSWORD']




uri = URI.parse("https://#{interface}.custhelp.com/services/rest/connect/v1.3/serviceProducts")
params = { :limit => 1 }
uri.query = URI.encode_www_form(params)

# puts uri


Net::HTTP.start(uri.host, uri.port,
  :use_ssl => uri.scheme == 'https', 
  :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

  request = Net::HTTP::Get.new uri.request_uri
  request.add_field('Content-Type', 'application/x-www-form-urlencoded')
  request.basic_auth username, password

  response = http.request request # Net::HTTPResponse object

  json_response = JSON.parse(response.body)

  puts JSON.pretty_generate(json_response)

end

# names = []

# names[0] = {:labelText => 'QTH45', :language => {:id => 1}}
# names[1] = {:labelText => 'QTH45', :language => {:id => 11}}

# GET available interfaces for selection
# /services/rest/connect/v1.3/siteInterfaces

# parent = {:id => 102}

# admin_user_visible_interfaces = []
# admin_user_visible_interfaces[0] = {:id => 1}

# end_user_visible_interfaces = []
# end_user_visible_interfaces[0] = {:id => 1}

# new_prod = []
# new_prod[0] = {:names => names, 
#                :parent => parent, 
#                :adminVisibleInterfaces => admin_user_visible_interfaces,
#                :endUserVisibleInterfaces => end_user_visible_interfaces}

# Net::HTTP.start(uri.host, uri.port,
#   :use_ssl => uri.scheme == 'https', 
#   :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

#   request = Net::HTTP::Post.new uri.request_uri
#   request.basic_auth username, password
#   request.content_type = "application/json"
#   request.body = JSON.dump(new_prod)

#   response = http.request request # Net::HTTPResponse object

#   json_response = JSON.parse(response.body)

#   puts JSON.pretty_generate(json_response)
# end