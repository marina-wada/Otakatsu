class AddAmountToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :amount, :integer
  end
end
