class CreateInquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :inquiries do |t|
      t.integer :user_id
      t.text :inquiry
      t.string :Inquiry_type
      t.integer :status

      t.timestamps
    end
  end
end
