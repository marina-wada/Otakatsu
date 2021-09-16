class RenameImageColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :image, :image_id
  end
end
