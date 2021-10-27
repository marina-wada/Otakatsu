class AddExchangeStatusToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :exchanged_user_id, :integer
    add_column :items, :exchanged_image_id, :string
    add_column :items, :exchange_status, :integer
  end
end
