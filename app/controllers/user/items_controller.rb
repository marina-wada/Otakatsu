class User::ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = current_user.items
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @items = current_user.items
    @genre = Genre.find(params[:genre_id])
  end

  def create
    @item = current_user.items.new(item_params)
    @item.save!
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
    params.require(:item).permit(:ask_item1, :ask_item2, :ask_item3, :ask_item4, :ask_item5, :character, :kind, :introduction, :genre_id, :image)
  end
end

