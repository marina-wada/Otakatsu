class Item < ApplicationRecord
  belongs_to :user
  has_many :exchanges, dependent: :destroy
  belongs_to :genre
  has_many :likes, dependent: :destroy
  attachment :item_image
  attachment :exchanged_image

  validates :image, presence: true
  validates :character, presence: true
  validates :ask_item1, presence: true

   enum item_status: { 未交換: 0, 承認: 1, 非承認: 2, 配送準備: 3, 配送済: 4, 受取済: 5, 交換グッズ確認: 6, グッズ状態ＮＧ: 7, 交換済: 8, 返品: 9 }
  # enum exchange_status: { 交換希望: 0, 配送準備: 1, 配送済: 2, 受取済: 3, グッズ状態ＮＧ: 4, 交換済: 5, 交換終了: 6, 返品: 7 }

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end
