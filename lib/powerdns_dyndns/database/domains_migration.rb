module PowerDNS
  module DynDNS
    class Database
      class DomainsMigration < ActiveRecord::Migration
        def change
          create_table :domains do |t|
            t.string   :name
            t.string   :master
            t.integer  :last_check
            t.string   :type,           default: 'NATIVE'
            t.integer  :notified_serial
            t.string   :account
            t.integer  :ttl,            default: 86400
            t.datetime :created_at,     null: false
            t.datetime :updated_at,     null: false
            t.integer  :user_id
            t.text     :notes
          end
        end
      end
    end
  end
end
