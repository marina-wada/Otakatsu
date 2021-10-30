class RenameStatusColumnOnExchanges < ActiveRecord::Migration[5.2]
  def change
    rename_column :exchanges, :status, :exchanged_status
  end
end
