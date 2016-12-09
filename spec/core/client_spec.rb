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
			end.to raise_error(NameError)
		end

		it 'should raise exception if username is blank' do
			expect do
				OSCRuby::Client.new do |config|
					config.username = ''
				end
			end.to raise_error(NameError)
		end

		it 'should raise exception if password is blank' do
			expect do
				OSCRuby::Client.new do |config|
					config.password = ''
				end
			end.to raise_error(NameError)
		end
	end
end