require 'core/spec_helper'
require 'json'
require 'uri'

describe OSCRuby::QueryResults do

	context "#select" do

		it 'should expect client is an instance of OSCRuby::Client class and raise an error if does not' do

			expect(client).to be_an(OSCRuby::Client)

			client = nil

			expect{new_answer.create(client)}.to raise_error('Client must have some configuration set; please create an instance of OSCRuby::Client with configuration settings')

		end
		
	end

end