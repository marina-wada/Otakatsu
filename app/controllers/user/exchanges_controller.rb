class User::ExchangesController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @user = @item.item_user
    @currentUserEntry = current_user.entries
    @userEntry = @user.entries
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId =cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def new
    @item = Item.find(params[:item_id])
  end

end
