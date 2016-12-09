require 'spec_helper'

describe OSCRuby do
  oscr = OSCRuby.new

  describe '.username' do
    it 'is not blank' do
      expect(oscr.username('rajan')).to eq 'rajan'
      expect{oscr.username()}.to raise_error(ArgumentError)
      expect{oscr.username('')}.to raise_error('OSCRuby.username must have a length greater than zero')
    end
  end

  describe '.password' do
    it 'is not blank' do
      expect(oscr.password('hjsfsf77y78787sydf')).to eq 'hjsfsf77y78787sydf'
      expect{oscr.password()}.to raise_error(ArgumentError)
      expect{oscr.password('')}.to raise_error('OSCRuby.password must have a length greater than zero')
    end
  end

  describe '.interface' do
    it 'is not blank' do
      expect(oscr.interface('hjsfsf77y78787sydf')).to eq 'hjsfsf77y78787sydf'
      expect{oscr.interface()}.to raise_error(ArgumentError)
      expect{oscr.interface('')}.to raise_error('OSCRuby.interface must have a length greater than zero')
    end
  end

end