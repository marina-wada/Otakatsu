class RenameAskItemeImageIdColumnToExchanges < ActiveRecord::Migration[5.2]
  def change
    rename_column :exchanges, :ask_iteme_image_id, :ask_item_image_id
  end
end
