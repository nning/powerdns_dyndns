require 'spec_helper'

describe Credentials do

  context '#authorized?' do
    it 'yes' do
      expect(subject.authorized?('test', 'example.org')).to be true
    end

    it 'no' do
      expect(subject.authorized?('test', 'example.com')).to be false 
      expect(subject.authorized?('foo', 'example.org')).to be false
    end
  end

  context '#valid?' do
    context 'invalid' do
      it 'username and password' do
        expect(subject.valid?('foo', 'bar')).to be false
      end

      it 'password' do
        expect(subject.valid?('test', 'bar')).to be false
      end
    end

    context 'valid' do
      it 'username and password' do
        expect(subject.valid?('test', 'test')).to be true
      end
    end
  end

end
