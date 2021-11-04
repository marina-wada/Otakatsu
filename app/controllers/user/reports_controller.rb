class User::ReportsController < ApplicationController
  before_action :authenticate_user!

  def create
    @item = Item.find(params[:item_id])
    report_count = Report.where(reported_id: @item.item_user_id).count
    @report = Report.new(reporter_id: current_user.id, reported_id: @item.item_user_id, amount: report_count+1)
    if @report.save
      if @report.amount > 10
        @item.item_user.update(is_active: "退会済")
        @item.item_user.likes.destroy_all
        @item.item_user.items.destroy_all
        @item.item_user.genres.destroy_all
        @item.item_user.exchanges.destroy_all
        @item.item_user.entries.destroy_all
        @item.item_user.messages.destroy_all
        @item.item_user.inquiries.destroy_all
        @item.item_user.reports.destroy_all
        @item.item_user.had_reports.destroy_all
        @item.item_user.active_notifications.destroy_all
        @item.item_user.passive_notifications.destroy_all
        redirect_to root_path and return
      end
      flash.now[:notice] = "通報しました"
      render 'user/items/show' and return
    else
      flash[:notice] = "既に通報済みです"
      redirect_to item_path(@item)
    end

  end
  private

  def report_params
    params.permit(:user_id, :item_id)
  end
end
