class Item < ApplicationRecord
  belongs_to :item_user, class_name: 'User'
  belongs_to :exchanged_user, class_name: 'User', optional: true
  has_many :exchanges, dependent: :destroy
  belongs_to :genre
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy

  attachment :item_image
  attachment :exchanged_image

  validates :item_image, presence: true
  validates :character, presence: true
  validates :ask_item1, presence: true

   enum item_status: { 未交換: 0, 承認: 1, 非承認: 2, 配送準備: 3, 配送済: 4, 受取済: 5, 交換グッズ確認: 6, グッズ状態ＮＧ: 7, 交換済: 8, 交換終了: 9, 返品: 10 }, _prefix: true
   enum exchange_status: { 交換希望: 0, 配送準備: 1, 配送済: 2, 受取済: 3, グッズ状態ＮＧ: 4, 交換済: 5, 交換終了: 6, 返品: 7 }, _prefix: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def select_item_status
    if exchange_status == '交換希望' && item_status == '未交換'
      Item.item_statuses.select{ |k,v| k == '承認' || k == '非承認'}
    elsif item_status == '承認'
      Item.item_statuses.select{ |k,v| k == '配送準備' || k == '配送済'}
    elsif item_status == '配送準備'
      Item.item_statuses.select{ |k,v| k == '配送準備' || k == '配送済'}
    elsif item_status == '配送済'
      Item.item_statuses.select{ |k,v| k == '受取済' || k == 'グッズ状態ＮＧ'}
    elsif item_status == 'グッズ状態ＮＧ'
      Item.item_statuses.select{ |k,v| k == '返品' || k == '交換終了'}
    elsif exchange_status == 'グッズ状態ＮＧ'
      Item.item_statuses.select{ |k,v| k == '返品' || k == '交換終了'}
    elsif item_status == '返品'
      Item.item_statuses.select{ |k,v| k == '配送準備' || k == '配送済'}
    else
      Item.item_statuses
    end
  end

  def select_exchanage_status
    if item_status == '承認'
      Item.exchange_statuses.select{ |k,v| k == '配送準備' || k == '配送済'}
    elsif exchange_status == '配送準備'
      Item.exchange_statuses.select{ |k,v| k == '配送準備' || k == '配送済'}
    elsif exchange_status == '配送済'
      Item.exchange_statuses.select{ |k,v| k == '受取済' || k == 'グッズ状態ＮＧ'}
    elsif exchange_status == 'グッズ状態ＮＧ'
      Item.exchange_statuses.select{ |k,v| k == '返品' || k == '交換終了'}
    elsif item_status == '返品'
      Item.exchange_statuses.select{ |k,v| k == '返品' ||k == '配送準備' || k == '配送済'}
    elsif exchange_status == '返品'
      Item.exchange_statuses.select{ |k,v| k == '配送準備' || k == '配送済'}
    else
      Item.exchange_statuses
    end
  end

  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(visited_id: item_user_id, action: "like", item_id: self.id)
    notification.save if notification.valid?
  end

  def create_exchange_notification_by(current_user)
    notification = current_user.active_notifications.new(visited_id: item_user_id, action: "exchange", item_id: self.id)
    notification.save if notification.valid?
  end

  def create_item_status_notification_by(current_user)
    notification = current_user.active_notifications.new(visited_id: exchanged_user_id, action: "status", item_id: self.id)
    notification.save if notification.valid?
  end

  def create_exchange_status_notification_by(current_user)
    notification = current_user.active_notifications.new(visited_id: item_user_id, action: "status", item_id: self.id)
    notification.save if notification.valid?
  end

end
