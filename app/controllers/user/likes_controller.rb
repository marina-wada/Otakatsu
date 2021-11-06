class User::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @item = Item.find(params[:item_id])
    @like = current_user.likes.new(item_id: @item.id)
    @like.save
    unless current_user == @item.item_user
      @item.create_notification_by(current_user)
    end
    redirect_to item_path(@item)
  end

  def destroy
    @item = Item.find(params[:item_id])
    @like = current_user.likes.find_by(item_id: @item.id)
    @like.destroy
    redirect_to item_path(@item)
  end

end
