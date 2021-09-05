class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :user_id
      t.string :character
      t.string :kind
      t.text :introduction
      t.string :image

      t.timestamps
    end
  end
end
