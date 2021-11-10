class Admin::ExchangesController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @exchanges = @item.exchanges
  end
end
