class AddColumnLastUpdaterToExchanges < ActiveRecord::Migration[5.2]
  def change
    add_column :exchanges, :last_updater, :integer
  end
end
