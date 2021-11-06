class User::MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    entry =Entry.where(user_id: current_user.id, room_id: params[:message][:room_id])
    if entry.present?
      @message = Message.new(message_params)
      @message.user_id = current_user.id
      @message.save
      @room = @message.room
      other_entry = @room.entries.where.not(user_id: current_user.id).first
      other_user = other_entry.user
      other_user.notice_to_receive_message(current_user, @message)
      redirect_to room_path(@message.room_id)
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
      redirect_to room_path(@message.room_id)
    end
    # @message_user = @message.user
    # @message_user.create_notification_message!(current_user, @message.id)
    

  end

  private
  def message_params
    params.require(:message).permit(:message, :room_id)
  end
end
