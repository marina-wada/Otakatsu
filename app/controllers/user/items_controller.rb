class User::ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit]

  def index
    @items = current_user.items
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @item.item_user_id = current_user.id
    @item.exchanged_user_id = nil
    @genre = Genre.find(params[:genre_id])
  end

  def create
    @item = current_user.items.new(item_params)
    @item.item_user_id = current_user.id
    @item.item_status = '未交換'
    if @item.save
       flash[:success] = '出品しました'
       redirect_to items_path
    else
       @items = current_user.items
       @genre = Genre.find_by(params[:genre_id])
       render :new
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:success] = '削除しました'
    redirect_to items_path
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.item_user_id == current_user.id
      if @item.item_status != item_params[:item_status]
        @item.update(item_params)
        flash[:success] = '更新が完了しました'
        @item.create_item_tatus_notification_by(current_user)
        @exchange = @item.exchanges.find_by(item_user_id: @item.item_user, exchanged_user_id: current_user.id)
        if @exchange.nil?
          @exchange = Exchange.new(item_id: @item.id, item_user_id: @item.item_user_id, exchanged_status: @item.exchange_status, exchanged_user_id: @item.exchanged_user_id, exchanged_item_id: @item.exchanged_item_id)
        end
          @exchange.item_status = @item.item_status
          @exchange.save
          redirect_to exchange_path(@item.id)
      else
        if @item.update(item_params)
          flash[:success] = '更新が完了しました'
          redirect_to item_path(@item)
        else
          flash.now[:alert] = '更新に失敗しました'
          render edit
        end
      end
    else
       @item.exchanged_user_id = current_user.id
       if @item.exchange_status = '交換希望'
        @item.update(item_params)
        @item.create_exchange_notification_by(current_user)
        @exchange = @item.exchanges.find_by(item_user_id: @item.item_user, exchanged_user_id: current_user.id)
        if @exchange == nil or @exchange.present?
          @exchange = Exchange.new
        end
          @exchange.item_id = @item.id
          if params[:ask_item] == "0"
            @ask_item = @item.ask_item1
          elsif params[:ask_item] == "1"
            @ask_item = @item.ask_item2
          elsif params[:ask_item] == "2"
            @ask_item = @item.ask_item3
          elsif params[:ask_item] == "3"
            @ask_item = @item.ask_item4
          elsif params[:ask_item] == "4"
            @ask_item = @item.ask_item5
          end
            @item.exchanged_item_id = params[:ask_item]
            @exchange.exchanged_item_id = @item.exchanged_item_id
            @exchange.item_user_id = @item.item_user_id
            @exchange.exchanged_user_id = @item.exchanged_user_id
            @exchange.exchanged_status = @item.exchange_status
            @item.save
            @exchange.save
            redirect_to exchange_path(@item.id)
       else
         @item.update(item_params)
         flash[:success] = '更新が完了しました'
         @item.create_exchange_status_notification_by(current_user)
         @exchange = @item.exchanges.find_by(item_user_id: @item.item_user, exchanged_user_id: current_user.id)
         if @exchange.present?
          @exchange = Exchange.new
         end
         @exchange.item_status = @item.item_status
         @exchange.exchanged_status = @item.exchange_status
         @exchange.save
         redirect_to exchange_path(@item.id)
       end
    end
  end

  def search
    if params[:character, :kind].present?
      @items = Item.where('character LIKE (?) OR kind LIKE (?)', "%#{params[:item]}%")
    else
      @items = Item.none
    end
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :exchanged_item_id, :item_image, :exchanged_image, :ask_item1, :ask_item2, :ask_item3, :ask_item4, :ask_item5, :character, :kind, :introduction, :item_status, :exchange_status)
  end
end

