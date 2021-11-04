class User::HomesController < ApplicationController
  def top
    @items = Item.where(item_status: [0,2]).where(exchange_status: nil).order(updated_at: :DESC)
  end
end
