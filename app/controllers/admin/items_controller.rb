class Admin::ItemsController < ApplicationController
  def index
    @user = User.find(params[:item_user_id])
    @items = @user.items.order(updated_at: :DESC)
  end
end
