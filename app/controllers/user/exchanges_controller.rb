class User::ExchangesController < ApplicationController
  def show
    @exchange = Exchange.find(params[:id])
    @item = @exchange.item
    # binding.pry
    # @user = @exchange.user
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

  def update
    @exchange = Exchange.find(params[:id])
    @exchange.user = current_user
    @exchange.status = '交換希望'
    @item = @exchange.item
    if params[:ask_item] == "0"
      @ask_item = @item.ask_item1
    elsif params[:ask_item] == "1"
          @ask_item = @item.ask_item2
    elsif params[:ask_item] == "2"
          @ask_item = @item.ask_item3
    elsif params[:ask_item] == "3"
          @ask_item = @item.ask_item4
    else  @ask_item = @item.ask_item5
    end
    if @exchange.update(exchange_params)
       redirect_to exchange_path(@exchange.id)
    else
       flash.now[:alert] = '求めるグッズ画像の添付をお願いします'
       render edit
    end
  end

  def new
    @exchange = Exchange.new
  end

  def edit
   @item = Item.find(params[:item_id])
   @exchange = Exchange.find(params[:id])
  end

  private

  def exchange_params
    params.require(:exchange).permit(:item_id, :user_id, :status, :ask_item_image)
  end
end
