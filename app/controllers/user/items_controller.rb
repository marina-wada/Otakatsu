class User::ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :show]

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
        @item.create_item_status_notification_by(current_user)
        @exchange = @item.exchanges.find_by(item_user_id: @item.item_user, exchanged_user_id: current_user.id)
        if @exchange.nil?
          @exchange = Exchange.new(item_id: @item.id, item_user_id: @item.item_user_id, exchanged_status: @item.exchange_status, exchanged_user_id: @item.exchanged_user_id, exchanged_item_id: @item.exchanged_item_id)
        end
          @exchange.item_status = @item.item_status
          @exchange.last_status = "item_status"
          @exchange.last_updater = current_user.id
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
       if @item.exchange_status == nil or @exchange.present?
         @item.exchange_status = '交換希望'
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
           @exchange.last_status = "exchanged_status"
           @item.save
           @exchange.last_updater = current_user.id
           @exchange.save
           redirect_to exchange_path(@item.id)

       elsif @item.item_status == '非承認' || @item.exchange_status == '交換希望'
         @item.item_status = '未交換'

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
           @exchange.last_status = "exchanged_status"
           @item.save
           @exchange.last_updater = current_user.id
           @exchange.save
           redirect_to exchange_path(@item.id)
       elsif @item.exchange_status != item_params[:exchange_status]
         @item.update(item_params)
         flash[:success] = '更新が完了しました'
         @item.create_exchange_status_notification_by(current_user)
         @exchange = @item.exchanges.find_by(item_user_id: @item.item_user, exchanged_user_id: current_user.id)
         if @exchange.present?
          @exchange = Exchange.new
         end
         @exchange.item_status = @item.item_status
         @exchange.exchanged_status = @item.exchange_status
         @exchange.last_status = "exchanged_status"
         @exchange.last_updater = current_user.id
         @exchange.save
         redirect_to exchange_path(@item.id)
       end
    end
  end

  def search
    if params[:keyword].present?
      genre_ids = Genre.where('name LIKE ?', "%#{params[:keyword]}%").pluck(:id)
      @items = Item.where('genre_id IN (?) OR items.character LIKE ? OR kind LIKE ? OR ask_item1 LIKE ? OR ask_item2 LIKE ? OR ask_item3 LIKE ? OR ask_item4 LIKE ? OR ask_item5 LIKE ?',
                            genre_ids, "%#{params[:keyword]}%",
                            "%#{params[:keyword]}%", "%#{params[:keyword]}%",
                            "%#{params[:keyword]}%", "%#{params[:keyword]}%",
                            "%#{params[:keyword]}%", "%#{params[:keyword]}%"
                            )
                    .where(item_status: [0,2]).where(exchange_status: nil).order(updated_at: :DESC)
    else
      @items = Item.where(item_status: [0,2]).where(exchange_status: nil).order(updated_at: :DESC)
    end
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :exchanged_item_id, :item_image, :exchanged_image, :ask_item1, :ask_item2, :ask_item3, :ask_item4, :ask_item5, :character, :kind, :introduction, :item_status, :exchange_status)
  end
end

