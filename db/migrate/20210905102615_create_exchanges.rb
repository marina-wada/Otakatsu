class CreateExchanges < ActiveRecord::Migration[5.2]
  def change
    create_table :exchanges do |t|
      t.integer :item_id
      t.integer :user_id
      t.integer :status

      t.timestamps
    end
  end
end
