class AddUserIdToEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :user_id, :integer
  end
end
