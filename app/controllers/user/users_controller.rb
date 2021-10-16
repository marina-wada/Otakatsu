class User::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :telephone_number, :postal_code, :address, :is_active, :email, :password, :password_confirmation)
  end
end
