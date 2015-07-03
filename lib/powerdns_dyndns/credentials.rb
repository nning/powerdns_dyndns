require 'powerdns_dyndns/app_config'

module PowerDNS
  module DynDNS
    module Credentials
      def self.authorized?(username, domain)
        AppConfig.instance['users'][username]['domains'].include?(domain)
      rescue NoMethodError
        false
      end

      def self.valid?(username, password)
        user = AppConfig.instance['users'][username]
        return false if user.nil?
        user['password'] == password
      end
    end
  end
end
