class RemoveAskItemImageIdFromExchanges < ActiveRecord::Migration[5.2]
  def change
    remove_column :exchanges, :ask_item_image_id, :string
  end
end
