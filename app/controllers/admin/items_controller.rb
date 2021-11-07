class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
    # @user = User.find(params[:item_user_id])
    # @items = @user.items
    @item = Item.find(params[:item_id])
    @report = Report.where(reported_id: @item.item_user_id)
    @item.report.amount = @report.amount
  end
end
