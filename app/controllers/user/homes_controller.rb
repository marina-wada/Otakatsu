class User::HomesController < ApplicationController
  def top
    @item.images = Item.all.order(updated_at: :DESC)
  end
end
