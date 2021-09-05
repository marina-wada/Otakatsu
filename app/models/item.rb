class Item < ApplicationRecord
  belongs_to :user
  belongs_to :exchanges
  belongs_to :genre
  has_many :likes, dependent: :destroy
end
