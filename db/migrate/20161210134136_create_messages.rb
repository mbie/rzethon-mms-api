class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.uuid :uuid, unique: true, null: false, primary: true
      t.string :content, null: false
      t.string :source, null: false
      t.string :destination, null: false

      t.timestamps
    end
  end
end
