class Exchange < ApplicationRecord
  belongs_to :user
  belongs_to :item, optional:true
  attachment :image

  # after_commit do
  #   if status == 1
  #     action = "交換を申請しました。"
  #   elsif status == 2
  #     action = "承認しました"
  #   end
  #   Notification.create!(visitor_id: 1, visited_id: 2, action: action) #右は変数のアクション　visitor.id,visited.idもexchageモデルから取得する
  # end

  enum status: { 未交換: 0, 交換希望: 1, 承認: 2, 非承認: 3, 配送準備: 4, 配送済: 5, 受取済: 6, 交換グッズ確認: 7, グッズ状態NG: 8, 交換済: 9, 返品: 10 }
end
