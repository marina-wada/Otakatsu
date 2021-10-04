class User::ReportsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    report_count = Report.where(reported_id: @item.user_id).count
    @report = Report.new(reporter_id: current_user.id, reported_id: @item.user_id, amount: report_count+1)
    if @report.save
      if @report.amount > 10
        @item.user.update(is_active: "退会済")
        @item.user.likes.destroy_all
        @item.user.items.destroy_all
        @item.user.genres.destroy_all
        @item.user.exchanges.destroy_all
        @item.user.entries.destroy_all
        @item.user.messages.destroy_all
        @item.user.inquiries.destroy_all
        @item.user.reports.destroy_all
        @item.user.had_reports.destroy_all
        @item.user.active_notifications.destroy_all
        @item.user.passive_notifications.destroy_all
        redirect_to root_path and return
      end
      flash[:notice] = "通報しました"
      render 'user/items/show' and return
    else
      flash[:notice] = "既に通報済みです"
      render 'user/items/show' and return
    end

  end
  private

  def report_params
    params.permit(:user_id, :item_id)
  end
end
