class RemoveItemIdFromGenres < ActiveRecord::Migration[5.2]
  def change
    remove_column :genres, :item_id, :integer
  end
end
