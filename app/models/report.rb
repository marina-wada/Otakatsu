class Report < ApplicationRecord
  belongs_to :user
  belongs_to :reported, class_name: "User", foreign_key: "reported_user_id"
  belongs_to :reporting, class_name: "User", foreign_key: "reporting_user_id"
  validates_uniqueness_of :reported_user_id, scope: :reporting_user_id
  # has_many :items, dependent: :destroy
end
