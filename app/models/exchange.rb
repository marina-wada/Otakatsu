class Exchange < ApplicationRecord

  # SYONIN = ["配送準備"].freeze
  belongs_to :user, optional: true
  belongs_to :item, optional: true
  attachment :ask_item_image

  delegate :user, to: :item, prefix: true

  # after_commit do
  #   if status == 1
  #     action = "交換を申請しました。"
  #   elsif status == 2
  #     action = "承認しました"
  #   end
  #   Notification.create!(visitor_id: 1, visited_id: 2, action: action) #右は変数のアクション　visitor.id,visited.idもexchageモデルから取得する
  # end

  enum status: { 交換希望: 0, 配送準備: 1, 配送済: 2, 受取済: 3, グッズ状態ＮＧ: 4, 交換済: 5, 返品: 6 }

  def user_status
    # binding.irb
    return self.class.statuses.keys.select { |st| st.in?(["配送準備"])} if status == "承認"
  end

  def not_exchange(current_user)
    return true if item_user == current_user && status == "交換希望"
    user == current_user && status != "交換希望"
  end
end
