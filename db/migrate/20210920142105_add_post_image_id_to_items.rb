class AddPostImageIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :post_image_id, :integer
  end
end
