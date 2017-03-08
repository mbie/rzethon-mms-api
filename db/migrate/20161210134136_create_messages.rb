class CreateMessages < ActiveRecord::Migration[5.0]
  @@is_sqlite = ActiveRecord::Base.connection.instance_of? ActiveRecord::ConnectionAdapters::SQLite3Adapter

  def change
    if not @@is_sqlite then
      execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\""
    end

    create_table :messages, id: :uuid do |t|
      #t.uuid :uuid, unique: true, null: false, primary: true
      t.string :content, null: false
      t.string :source, null: false
      t.string :destination, null: false

      t.timestamps
    end
  end
end
