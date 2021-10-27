class RenameUserIdColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :user_id, :item_user_id
    rename_column :items, :image_id, :item_image_id
  end
end
