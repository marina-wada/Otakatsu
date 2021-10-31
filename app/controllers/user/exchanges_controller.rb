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
    else
      #@room_id = Entry.where(item_id: @item).pluck(:room_id)
      #@isRoom = true
      entry1 = Entry.where(user_id: current_user)
      entry2 = Entry.where(user_id: @item.exchanged_user)
      entry1.each do |e1|
        entry2.each do |e2|
          if e1.room_id == e2.room_id
            @roomId = e1.room_id
            @isRoom = true
          end
        end
      end

    end
  end

  def new
    @item = Item.find(params[:item_id])
  end

end
