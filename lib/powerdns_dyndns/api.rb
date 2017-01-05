require 'powerdns_db_cli'
require 'powerdns_dyndns/credentials'
require 'powerdns_dyndns/database'
require 'sinatra'

module PowerDNS
  module DynDNS
    class API < Sinatra::Base
      use Rack::Auth::Basic, 'DynDNS' do |username, password|
        Credentials.valid?(username, password)
      end

      get '/nic/update/?' do
        ip = request['myip'] || request.env['REMOTE_ADDR']

        return 400 unless ip_valid?(ip)

        Database.connect!

        return 401 unless Credentials.authorized? \
          request.env['REMOTE_USER'],
          request['hostname']

        record = DB::Record.where(name: request['hostname'], type: 'A').first

        return 400 unless record

        if record.content != ip
          record.content = ip
          record.save!

          return 200
        end

        400
      end

      private

      def ip_valid?(a)
        return false if a.nil? || a.empty? || a == '0.0.0.0'
        a = Addrinfo.ip(a)
      rescue SocketError
        false
      else
        a.ipv4? && !(a.ipv4_loopback? || a.ipv4_multicast? || a.ipv4_private?)
      end
    end
  end
end
