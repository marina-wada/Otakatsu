class Item < ApplicationRecord
  belongs_to :item_user, class_name: 'User'
  belongs_to :exchanged_user, class_name: 'User'
  has_many :exchanges, dependent: :destroy
  belongs_to :genre
  has_many :likes, dependent: :destroy
  attachment :item_image
  attachment :exchanged_image

  validates :item_image, presence: true
  validates :exchanged_image, presence: true
  validates :character, presence: true
  validates :ask_item1, presence: true

   enum item_status: { 未交換: 0, 承認: 1, 非承認: 2, 配送準備: 3, 配送済: 4, 受取済: 5, 交換グッズ確認: 6, グッズ状態ＮＧ: 7, 交換済: 8, 交換終了: 9, 返品: 10 }, _prefix: true
   enum exchange_status: { 交換希望: 0, 配送準備: 1, 配送済: 2, 受取済: 3, グッズ状態ＮＧ: 4, 交換済: 5, 交換終了: 6, 返品: 7 }, _prefix: true

  def liked_by?(user)
    likes.where(user_id: item_user.id).exists?
  end

  def select_item_status
    if exchange_status == '交換希望'
       Item.item_statuses.select{ |k,v| k == '承認' || k == '非承認'}
    elsif item_status == '承認'
      　　Item.item_statuses.select{ |k,v| k == '配送準備' || k == '配送済'}
    elsif item_status == '配送済'
      　　Item.item_statuses.select{ |k,v| k == '受取済' || k == 'グッズ状態ＮＧ'}
    elsif item_status == 'グッズ状態ＮＧ'
      　　Item.item_statuses.select{ |k,v| k == '返品' || k == '交換終了'}
    else
       Item.item_statuses
    end
  end

  def select_exchnage_status
    if exchange_status == '交換希望'
       Item.item_statuses.select{ |k,v| k == '承認' || k == '非承認'}
    elsif item_status == '承認'
      　　Item.item_statuses.select{ |k,v| k == '配送準備' || k == '配送済'}
    elsif item_status == '配送済'
      　　Item.item_statuses.select{ |k,v| k == '受取済' || k == 'グッズ状態ＮＧ'}
    elsif item_status == 'グッズ状態ＮＧ'
      　　Item.item_statuses.select{ |k,v| k == '返品' || k == '交換終了'}
    else
       Item.item_statuses
    end
  end

end
