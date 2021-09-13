class User::ItemsController < ApplicationController
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

