class User::HomesController < ApplicationController
  def top
    @items = Item.all.order(updated_at: :DESC)
  end
end
