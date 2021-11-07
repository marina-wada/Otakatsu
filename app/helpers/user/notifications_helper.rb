module User::NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor
    @message = nil
    @visitor_message = notification.message_id
    case notification.action
      when "like" then
        tag.a(notification.visitor.nickname, style: "font-weight: bold;")+"が"+tag.a('あなたのグッズ', href: item_path(notification.item.id), style: "font-weight: bold;")+"にいいねしました"
      when "message" then
        @message = Message.find_by(id: @visitor_message)&.message
        @room = Message.find_by(id: @visitor_message).room
        tag.a(@visitor.nickname, style: "font-weight: bold;")+"から"+tag.a('メッセージ', href: room_path(@room.id), style: "font-weight: bold;")+"が届きました"
      when "exchange" then
        tag.a(notification.visitor.nickname, style: "font-weight: bold;")+"が"+tag.a('あなたのグッズ', href: item_path(notification.item.id), style: "font-weight: bold;")+"に交換申し込みがありました"
        when "status" then
        tag.a(notification.visitor.nickname, style: "font-weight: bold;")+"が"+tag.a('交換', href: item_path(notification.item.id), style: "font-weight: bold;")+"ステータスを更新しました"
    end
  end

end
