module PowerDNS
  module DynDNS
    class Database
      include Singleton

      def initialize
        @@config = nil
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

          migrate_test!
        else
          ActiveRecord::Base.establish_connection(@config)
        end
      end

      def migrate_test!
        begin
          DB::Record.first
        rescue ActiveRecord::StatementInvalid
          require 'powerdns_dyndns/database/records_migration'
          ActiveRecord::Migration.verbose = false
          RecordsMigration.migrate(:up)
        end
      end
    end
  end
end
