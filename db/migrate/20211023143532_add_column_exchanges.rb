class AddColumnExchanges < ActiveRecord::Migration[5.2]
  def change
    add_column :exchanges, :ask_iteme_image_id, :integer
  end
end
