require 'powerdns_dyndns/app_config'

module PowerDNS
  module DynDNS
    class Database
      include Singleton

      def initialize
        @@config = AppConfig.instance

        establish_connection!
        migrate_test! if test?
      end

      def self.connect!
        instance
      end

      private

      def establish_connection!
        ActiveRecord::Base.establish_connection(@@config['database'])
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

      def test?
        ENV['RACK_ENV'] == 'test'
      end
    end
  end
end
