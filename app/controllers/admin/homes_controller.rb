class Admin::HomesController < ApplicationController
  def top
    @exchanges = Exchange.all
  end
end
