class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :likes, dependent: :destroy
  has_many :items, dependent: :destroy, class_name: 'Item', foreign_key: 'item_user_id'
  has_many :ask_items, class_name: 'Item', foreign_key: 'exchanged_user_id'
  has_many :genres, through: :items
  has_many :exchanges, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :inquiries, dependent: :destroy

  has_many :reports, foreign_key: "reporter_id", dependent: :destroy
  has_many :had_reports, class_name: "Report", foreign_key: "reported_id", dependent: :destroy

  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  enum is_active: { '有効': true, '退会済': false }

  validates :name, presence: true
  validates :nickname, presence: true
  validates :telephone_number, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true

  def active_for_authentication?
    super && self.is_active == '有効'
  end

  def item_by?(item)
    self.items.exists?(id: item.id)
  end

  def notice_to_receive_message(send_user, message)
    notification = Notification.new(
      visitor_id: send_user.id,
      visited_id: self.id,
      action: "message",
      message_id: message.id
    )
    notification.save
  end

  # def create_notification_message!(current_user, message_id)
  #   temp_ids = Message.select(:user_id).where(user_id: id).where.not(user_id: current_user.id).distinct
  #   temp_ids.each do |temp_id|
  #     save_notification_message!(current_user, message_id, temp_id['user_id'])
  #   end
  #   # save_notification_message!(current_user, message_id, user_id) if temp_ids.blank?
  #   save_notification_message!(current_user, message_id) if temp_ids.blank?
  # end

  # # def save_notification_message!(current_user, message_id, visited_id)
  # def save_notification_message!(current_user, message_id)
  #   # notification = current_user.active_notifications.new(message_id: message_id, visited_id: visited_id, action: 'message')
  #   notification = current_user.active_notifications.new(message_id: message_id, action: 'message')
  #   if notification.visitor_id == notification.visited_id
  #     notification.checked = true
  #   end
  #   notification.save if notification.valid?
  # end

end
