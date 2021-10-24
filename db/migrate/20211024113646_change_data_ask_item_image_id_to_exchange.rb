class ChangeDataAskItemImageIdToExchange < ActiveRecord::Migration[5.2]
  def change
    change_column :exchanges, :ask_item_image_id, :string
  end
end
