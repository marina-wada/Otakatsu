class User::ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = current_user.items
  end

  def new
    @item = Item.new
    @items = current_user.items
    @genre = Genre.find(params[:genre_id])
  end

  def create
    @item = current_user.items.new(item_params)
    @item.save
    redirect_to items_path
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
    @item.update
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
    # もしimages: [] でうまくいかなければ
    # images: [] から
    # :images に変えてください
    params.require(:item).permit(:ask_item, :character, :kind, :introduction, :genre_id, images: [])
  end
end

