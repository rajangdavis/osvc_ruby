require 'core/spec_helper'

describe OSCRuby::Client do
	subject { client }

	context '#initialize' do
		it 'should require a block' do
			expect { OSCRuby::Client.new }.to raise_error(ArgumentError)
		end

		it 'should raise exception if interface is blank' do
			expect do
				OSCRuby::Client.new do |config|
					config.interface = ''
				end
			end.to raise_error("Interface cannot be nil or blank")
		end

		it 'should raise exception if username is blank' do
			expect do
				OSCRuby::Client.new do |config|
					config.interface = 'test'
					config.username = ''
				end
			end.to raise_error("Username cannot be nil or blank")
		end

		it 'should raise exception if password is blank' do
			expect do
				OSCRuby::Client.new do |config|
					config.interface = 'test'
					config.username = 'test_username'
					config.password = ''
				end
			end.to raise_error("Password cannot be nil or blank")
		end

		it 'should create a configuration object' do
			expect do
				client = OSCRuby::Client.new do |config|
					config.interface = 'test'
					config.username = 'test_username'
					config.password = 'test_password'
				end

				client.config.interface.should eq('test')
				client.config.interface.should !='test1'

				client.config.username.should eq('test_username')
				client.config.username.should !='test1_username'

				client.config.interface.should eq('test_password')
				client.config.interface.should !='test1_password'
			end
		end
	end
end