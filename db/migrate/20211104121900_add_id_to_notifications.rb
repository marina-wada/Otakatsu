class AddIdToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :like_id, :integer
    add_column :notifications, :item_id, :integer
    add_column :notifications, :message_id, :integer
  end
end
