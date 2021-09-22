class AddAskItem1ToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :ask_item1, :string
    add_column :items, :ask_item2, :string
    add_column :items, :ask_item3, :string
    add_column :items, :ask_item4, :string
    add_column :items, :ask_item5, :string
  end
end
