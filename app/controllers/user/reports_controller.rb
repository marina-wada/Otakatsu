class User::ReportsController < ApplicationController
  def create
    @report = Report.new
  end
  
end
