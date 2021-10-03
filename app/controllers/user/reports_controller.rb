class User::ReportsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    report_count = Report.where(reported_id: @item.user_id).count
    @report = Report.new(reporter_id: current_user.id, reported_id: @item.user_id, amount: report_count+1)
    if @report.save
      if @report.amount > 10
        @report.reported_id.update(is_active: false)
        redirect_to root_path
      end
      redirect_to item_path(@item), notice: "通報しました"
    else flash[:notice] = "既に通報済みです"
      render 'user/items/show'
    end

  end

  # def withdrawl
  #   @report = Report.find(report_params)
  #   if @report.amount > 10
  #     @report.reported_id.update(is_active: false)
  #     redirect_to root_path
  #   end
  # end

  # def check

  # end

  private

  def report_params
    params.permit(:user_id, :item_id)
  end



end
