class User::ReportsController < ApplicationController
  def new
    @report = Report.new
  end

  def create
    @report = Report.find(params[:id])
    @report.save
    redirect_to item_path(@item)
  end

end
