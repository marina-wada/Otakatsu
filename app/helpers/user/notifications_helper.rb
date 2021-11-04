module User::NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor
    @message = nil
    your_item = link_to 'あなたの投稿', room_path(@room.id), style: "font-weight: bold;"
    @visitor_message = notification.message_id
    case notification.action
      when "like" then
        tag.a(notification.visitor.nickname, href: user_path(@visitor), style: "font-weight: bold;")+"が"+tag.a('あなたのグッズ', href: item_path(notification.item.id), style: "font-weight: bold;")+"にいいねしました"
      when "message" then
        @message = Message.find_by(id: @visitor_message)&.message
        tag.a(@visitor.nickname, href: user_path(@visitor), style: "font-weight: bold;")+"から"+tag.a('メッセージ', href: room_path(@room.id), style: "font-weight: bold;")+"が届きました"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
