class AddUuidToMessages < ActiveRecord::Migration[5.0]
  @@is_sqlite = ActiveRecord::Base.connection.instance_of? ActiveRecord::ConnectionAdapters::SQLite3Adapter

  def up
    #if not @@is_sqlite then
      #execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\""
      #execute "ALTER TABLE messages ADD COLUMN uuid uuid UNIQUE NOT NULL DEFAULT uuid_generate_v4()"
    #end
  end

  def down
    #if not @@is_sqlite then
      #execute "ALTER TABLE messages DROP COLUMN uuid"
      #execute "DROP EXTENSION IF EXISTS \"uuid-ossp\""
    #end
  end
end
