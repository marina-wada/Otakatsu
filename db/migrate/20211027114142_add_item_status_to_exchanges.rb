class AddItemStatusToExchanges < ActiveRecord::Migration[5.2]
  def change
    add_column :exchanges, :exchanged_item_id, :integer
    add_column :exchanges, :item_status, :integer
  end
end
