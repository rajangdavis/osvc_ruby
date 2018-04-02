require 'core/spec_helper'

describe OSvCRuby::Client do
	subject { client }

	context '#initialize' do
		
		it 'should require a block' do
			expect { OSvCRuby::Client.new }.to raise_error(ArgumentError)
		end

		it 'should raise exception if interface is blank' do
			expect do
				OSvCRuby::Client.new do |config|
					config.interface = ''
				end
			end.to raise_error("Interface cannot be nil or blank")
		end

		it 'should raise exception if username is blank' do
			expect do
				OSvCRuby::Client.new do |config|
					config.interface = 'test'
					config.username = ''
				end
			end.to raise_error("Username cannot be nil or blank")
		end

		it 'should raise exception if password is blank' do
			expect do
				OSvCRuby::Client.new do |config|
					config.interface = 'test'
					config.username = 'test_username'
					config.password = ''
				end
			end.to raise_error("Password cannot be nil or blank")
		end

		it 'should raise exception if no_ssl_verify not a TrueClass nor a FalseClass' do
			expect do
				OSvCRuby::Client.new do |config|
					config.interface = 'test'
					config.username = 'test_username'
					config.password = 'password'
					config.no_ssl_verify = 'true'
				end
			end.to raise_error("The no SSL verification setting must be set to true or false")
		end

		it 'should raise exception if Connect Version is null' do
			expect do
				OSvCRuby::Client.new do |config|
					config.interface = 'test'
					config.username = 'test_username'
					config.password = 'password'
					config.version = nil
				end
			end.to raise_error("Connect version cannot be null")
		end

		let(:client){
			OSvCRuby::Client.new do |config|
				config.interface = 'test'
				config.username = 'test_username'
				config.password = 'test_password'
				config.no_ssl_verify = true
			end
		}

		it 'should create a configuration object' do

			expect{client}.to_not raise_error

		end

		it 'should have interface set to "test" and not "test1"' do
			expect(client.config.interface).to eq('test')
			expect(client.config.interface).not_to eq('test1')
		end

		it 'should have username set to "test_username" and not "test1_username"' do
			expect(client.config.username).to eq('test_username')
			expect(client.config.username).not_to eq('test1_username')
		end

		it 'should have password set to "test_password" and not "test1_password"' do
			expect(client.config.password).to eq('test_password')
			expect(client.config.password).not_to eq('test1_password')
		end

		it 'should have no_ssl set to true and not false' do
			expect(client.config.no_ssl_verify).to eq(true)
			expect(client.config.no_ssl_verify).not_to eq(false)
		end

	end
end