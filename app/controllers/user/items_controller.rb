class User::ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = current_user.items
  end

  def new
    @item = Item.new
    @items = current_user.items
    @genre = current_user.genres
  end

  def create
    @item = Item.new(item_params)
    item.save
    redirect_to items_path
  end

  def destroy
    @items = Item.find(params[:id])
    @items.destroy
    redirect_to new_item_path
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
    params.require(:item).permit(:ask_item, :character, :kind, :introduction, :image)
  end
end

