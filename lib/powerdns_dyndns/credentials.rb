require 'powerdns_dyndns/app_config'

module PowerDNS
  module DynDNS
    module Credentials
      def self.valid?(username, password)
        if ENV['RACK_ENV'] == 'test'
          return true if username == 'test' && password == 'test'
        end

        false
      end
    end
  end
end
