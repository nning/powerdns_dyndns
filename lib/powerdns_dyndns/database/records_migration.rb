module PowerDNS
  module DynDNS
    class Database
      class RecordsMigration < ActiveRecord::Migration
        def change
          create_table :records do |t|
            t.integer   :domain_id,   null: false, default: 0
            t.string    :name,        null: false
            t.string    :type,        null: false, default: 'A'
            t.string    :content,     null: false
            t.integer   :prio,        null: false, default: 0
            t.boolean   :auth,        null: false, default: true
            t.integer   :ttl,         null: false, default: 0
            t.timestamp :change_date, null: false, default: 0
          end
        end
      end
    end
  end
end
