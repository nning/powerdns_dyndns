$:.unshift(File.expand_path('../../lib', __FILE__))

ENV['RACK_ENV'] = 'test'

require 'powerdns_dyndns'
require 'rack/test'

include PowerDNS::DynDNS

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
