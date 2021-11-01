class User::HomesController < ApplicationController
  def top
    # @items = Item.includes(:exchanges).where(exchanges: {status: [0,9]}).order(updated_at: :DESC)
    @items = Item.where(item_status: [0,2], exchange_status: [0]).order(updated_at: :DESC)
  end
end
