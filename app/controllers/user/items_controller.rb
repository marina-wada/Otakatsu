class User::ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = current_user.items
  end

  def show
    @item = Item.find(params[:id])
    @exchange = @item.exchanges.order(:updated_at, :desc).last
  end

  def new
    @item = Item.new
    @genre = Genre.find(params[:genre_id])
    @exchange = @item.exchanges.build
  end

  def create
    @item = current_user.items.new(item_params)
    @item.exchanges.build(status: '未交換')
    # @exchange = @item.exchange.create(status: '未交換')
    # @item.exchange_id = @exchange.id
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
    redirect_to new_item_path(@item.genre_id)
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
       flash[:success] = '更新が完了しました'
       redirect_to item_path(@item)
    else
      flash.now[:alert] = '更新に失敗しました'
      render edit
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
    params.require(:item).permit(:ask_item1, :ask_item2, :ask_item3, :ask_item4, :ask_item5, :character, :kind, :introduction, :genre_id, :image)
  end
end

