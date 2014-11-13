require 'powerdns_dyndns/credentials'
require 'sinatra'

module PowerDNS
  module DynDNS
    class API < Sinatra::Base
      use Rack::Auth::Basic, 'DynDNS' do |username, password|
        Credentials.valid?(username, password)
      end

      get '/nic/update' do
        return 400 unless params_valid?
        200
      end

      private

      def params_valid?
        return false if request['hostname'].nil? || request['myip'].nil?
        true
      end
    end
  end
end
