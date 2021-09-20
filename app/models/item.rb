class Item < ApplicationRecord
  belongs_to :user
  belongs_to :exchange,optional:true
  belongs_to :genre
  has_many :likes, dependent: :destroy
  has_many :post_images, inverse_of: :item, dependent: :destroy
  accepts_nested_attributes_for :post_images, allow_destroy: true
  validates_associated :post_images

  validates :ask_item, presence: true
  validates :character, presence: true
  validates :image, presence: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end
