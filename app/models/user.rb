class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :likes, dependent: :destroy
  has_many :items, dependent: :destroy
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

  def exchanged_by? item
    self.exchanges.exists?(item_id: item.id)
  end

end
