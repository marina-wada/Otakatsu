class User::UsersController < ApplicationController
  def show
    @user = current_user
  end
end
