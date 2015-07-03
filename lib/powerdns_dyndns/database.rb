require 'powerdns_dyndns/app_config'

module PowerDNS
  module DynDNS
    class Database
      include Singleton

      def initialize
        @@config = AppConfig.instance
        @@test = ENV['RACK_ENV'] == 'test'

        establish_connection
      end

      def self.connect!
        instance
      end

      private

      def establish_connection
        if @@test
          @@connection ||= ActiveRecord::Base.establish_connection \
            adapter: 'sqlite3', database: ':memory:'
        else
          ActiveRecord::Base.establish_connection(@@config[:database])
        end

        migrate_test!
      end

      def migrate_test!
        begin
          DB::Record.first
        rescue ActiveRecord::StatementInvalid
          require 'powerdns_dyndns/database/domains_migration'
          require 'powerdns_dyndns/database/records_migration'

          ActiveRecord::Migration.verbose = false

          DomainsMigration.migrate(:up)
          RecordsMigration.migrate(:up)
        end
      end
    end
  end
end
