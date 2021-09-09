class Exchange < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

  after_commit do
    if status == 1
      action = "交換を申請しました。"
    elsif status == 2
      action = "承認しました"
    end
    Notification.create!(visitor_id: 1, visited_id: 2, action: action) #右は変数のアクション　visitor.id,visited.idもexchageモデルから取得する
  end
end
