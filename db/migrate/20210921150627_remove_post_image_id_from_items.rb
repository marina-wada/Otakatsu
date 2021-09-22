class RemovePostImageIdFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :post_image_id, :integer
  end
end
