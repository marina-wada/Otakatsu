class RemoveAskItemFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :ask_item, :string
  end
end
