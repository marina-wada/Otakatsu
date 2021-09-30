class User::ReportsController < ApplicationController
  def create
    @report = Report.new(report_params)
    @item = Item.find(params[:item_id])
    report_count = Report.where(reported_id: params[:user_id]).count
    @report.save(reporter_id: current_user.id, reported_id: params[:user_id], amount: report_count)
    redirect_to item_path(@item)
  end

  def withdrawl
    @report = Report.find(report_params)
    if @report.amount > 10
      @report.reported_id.update(is_active: false)
      redirect_to root_path
    end
  end
  
  def check
    
  end

  private

  def report_params
    params.permit(:user_id, :item_id)
  end



end
