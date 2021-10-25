class Item < ApplicationRecord
  belongs_to :user
  has_many :exchanges, dependent: :destroy
  belongs_to :genre
  has_many :likes, dependent: :destroy
  attachment :image

  validates :image, presence: true
  validates :character, presence: true
  validates :ask_item1, presence: true

  enum item_status: { 未交換: 0, 承認: 1, 非承認: 2, 配送準備: 3, 配送済: 4, 受取済: 5, 交換グッズ確認: 6, グッズ状態ＮＧ: 7, 交換済: 8, 返品: 9 }

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end
