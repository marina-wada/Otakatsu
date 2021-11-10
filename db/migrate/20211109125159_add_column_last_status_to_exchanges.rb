class AddColumnLastStatusToExchanges < ActiveRecord::Migration[5.2]
  def change
    add_column :exchanges, :last_status, :string
  end
end
