class CreateNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :nodes do |t|
      t.string :name, null: false
      t.string :host, null: false
      t.decimal :location_x, scale: 12, precision: 16, null: false
      t.decimal :location_y, scale: 12, precision: 16, null: false
      t.decimal :location_z, scale: 12, precision: 16, null: false
      t.datetime :refreshed_at, null: false
    end
  end
end
