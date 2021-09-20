class AddExcangedIdToExcanges < ActiveRecord::Migration[5.2]
  def change
    add_column :exchanges, :exchanged_id, :integer
  end
end
