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

  def unsubscribe
    @user = User.find(current_user.id)
  end

  def check
    @user = User.find(params[:id])
  end

  def withdrawl
    @user = User.find(current_user.id)
    @user.update(is_active: '退会済')
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :telephone_number, :postal_code, :address, :is_active, :email, :password, :password_confirmation)
  end
end
