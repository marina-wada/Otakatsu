class RenameUserIdColumnToExchanges < ActiveRecord::Migration[5.2]
  def change
    rename_column :exchanges, :user_id, :item_user_id
    rename_column :exchanges, :exchanged_id, :exchanged_user_id
  end
end
