require 'osc_ruby'

rn_client = OSCRuby::Client.new do |config|
	config.username = ENV['OSC_ADMIN']
	config.password = ENV['OSC_PASSWORD']
	config.interface = ENV['OSC_TEST_SITE']
end


# ServiceProduct fetch example

	product = ServiceProduct.find(rn_client,100)

	puts product

	# => #<ServiceProduct:0x007fd0fa87e588>

	puts product.name

	# => QR404

	puts product.displayOrder

	# => 3

# ServiceProduct fetch all example

	products = OSCRuby::ServiceProduct.all(rn_client)

	products.each do |p|

		puts p.name

	end

	# => Unsure
	# => DVR/NVR
	# => QC Series
	# => QR Series
	# => QR404
	# => QS Series
	# => QT Series