class User::ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
    # @items = current_user.item
  end

  def create
  end

  def search
    if params[:character, :kind].present?
      @items = Item.where('character LIKE (?) OR kind LIKE (?)', "%#{params[:item]}%")
    else
      @items = Item.none
    end
  end

  def index
    @items = Item.all
  end
end

