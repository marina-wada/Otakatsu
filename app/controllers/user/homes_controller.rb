class User::HomesController < ApplicationController
  def top
    @items = Item.where(item_status: [0]).where(exchange_status: nil).or(Item.where(item_status: [2])).order(updated_at: :DESC)
  end
end
