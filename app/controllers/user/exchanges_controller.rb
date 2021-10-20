class User::ExchangesController < ApplicationController
  def show
    @exchange = Exchange.find(params[:id])
    @item = @exchange.item
    @user = @exchange.item.user
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
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

  def create
    @exchange = current_user.exchanges.new(exchange_params)
    @item = Item.find_by(params[:id])
    #@item = Item.find(params[:item][:item_id])
    # binding.pry
    if params[:exchange][:ask_item] == "0"
      @ask_item = @item.ask_item1
    elsif params[:exchange][:ask_item] == "1"
          @ask_item = @item.ask_item2
    elsif params[:exchange][:ask_item] == "2"
          @ask_item = @item.ask_item3
    elsif params[:exchange][:ask_item] == "3"
          @ask_item = @item.ask_item4
    else  @ask_item = @item.ask_item5
    end
    @exchange.save
    redirect_to exchange_path(@exchange.id)
  end

  def new
    @item = Item.find(params[:item_id])
    @exchange = Exchange.new
  end

  private

  def exchange_params
    params.require(:exchange).permit(:item_id, :user_id, :status)
  end
end
