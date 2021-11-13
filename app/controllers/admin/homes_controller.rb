class Admin::HomesController < ApplicationController
  def top

    if params[:item_user_id] != nil
      @user = User.find(params[:item_user_id])
      @items = @user.items
    else
      @items = Item.all.order(updated_at: :DESC)
    end
  end
end
