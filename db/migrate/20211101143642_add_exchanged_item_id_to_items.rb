class AddExchangedItemIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :exchanged_item_id, :integer
  end
end
