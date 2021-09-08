class ChangeNameToUsersNull < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :is_active, from: nil, to: false
    change_column_null :users, :is_active, false, false
  end
end
