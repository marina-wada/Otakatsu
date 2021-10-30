class Exchange < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :item, optional: true

  delegate :user, to: :item, prefix: true

  # after_commit do
  #   if status == 1
  #     action = "交換を申請しました。"
  #   elsif status == 2
  #     action = "承認しました"
  #   end
  #   Notification.create!(visitor_id: 1, visited_id: 2, action: action) #右は変数のアクション　visitor.id,visited.idもexchageモデルから取得する
  # end

  enum item_status: { 承認: 0, 非承認: 1, 配送準備: 2, 配送済: 3, 受取済: 4, 交換グッズ確認: 5, グッズ状態ＮＧ: 6, 交換済: 7, 返品: 8 }, _prefix: true
  enum exchanged_status: { 交換希望: 0, 配送準備: 1, 配送済: 2, 受取済: 3, グッズ状態ＮＧ: 4, 交換済: 5, 交換終了: 6, 返品: 7 }, _prefix: true

end
