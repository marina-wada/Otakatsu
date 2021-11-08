class Admin::ExchangesController < ApplicationController
  def show
    @exchanges = Exchange.where(exchanged_user_id: exchanged_user.id).where(item_user_id: item_user.id)
  end
end
