class Item < ApplicationRecord
  belongs_to :user
  has_many :exchanges, dependent: :destroy
  belongs_to :genre
  has_many :likes, dependent: :destroy
  attachment :image

  validates :image, presence: true
  validates :character, presence: true
  validates :ask_item1, presence: true



  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end
