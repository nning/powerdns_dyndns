$:.unshift(File.expand_path('../../lib', __FILE__))

ENV['RACK_ENV'] = 'test'

require 'powerdns_dyndns'
require 'rack/test'

include PowerDNS
include PowerDNS::DynDNS

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
