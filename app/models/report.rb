class Report < ApplicationRecord
  belongs_to :reported, class_name: "User", foreign_key: "reported_id"
  belongs_to :reporting, class_name: "User", foreign_key: "reporter_id"
  validates_uniqueness_of :reported_id, scope: :reporter_id
end
