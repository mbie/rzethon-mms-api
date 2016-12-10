class AddUuidToMessages < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\""
    execute "ALTER TABLE messages ADD COLUMN uuid uuid UNIQUE NOT NULL DEFAULT uuid_generate_v4()"
  end

  def down
    execute "ALTER TABLE messages DROP COLUMN uuid"
    execute "DROP EXTENSION IF EXISTS \"uuid-ossp\""
  end
end
