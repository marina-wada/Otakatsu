class User::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def withdrawl
    @user = User.find(current_user.id)
    if @reported_user_id.amount > 10
      @user.update(is_active: false)
    else
      @user.update(is_active: false)
      reset_session
      redirect_to root_path
    end
  end
end
