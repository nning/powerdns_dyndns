$:.unshift(File.expand_path('../lib', __FILE__))

require 'powerdns_dyndns'

run PowerDNS::DynDNS::API.new
