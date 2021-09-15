class User::HomesController < ApplicationController
  def top
    @exchange = Exchange.all

  end
end
