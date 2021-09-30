class Item < ApplicationRecord
  belongs_to :user
  belongs_to :exchange,optional:true
  belongs_to :genre
  has_many :likes, dependent: :destroy
  attachment :image
  validates :ask_item1, presence: true
  validates :character, presence: true
  validates :image, presence: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end
