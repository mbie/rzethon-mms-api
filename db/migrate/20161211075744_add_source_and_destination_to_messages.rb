class AddSourceAndDestinationToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :source, :string, null: false
    add_column :messages, :destination, :string, null: false
  end
end
