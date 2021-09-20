class CreatePostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_images do |t|
      t.integer :item_id
      t.string :image_id

      t.timestamps
    end
  end
end
