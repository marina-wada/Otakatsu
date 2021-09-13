class AddAskItemToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :ask_item, :string
  end
end
