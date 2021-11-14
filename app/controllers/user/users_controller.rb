class User::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
    redirect_to root_path unless current_user.id == @user.id
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "更新が完了しました"
      redirect_to user_path(@user)
    else
      flash[:alert] = "更新に失敗しました"
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
    if @user.update(is_active: '退会済')
      reset_session
      flash[:success] = "退会手続きが完了いたしました"
      redirect_to root_path
    else
      flash[:alert] = "退会手続きに失敗しました。再度手続きをおねがいいたします"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :telephone_number, :postal_code, :address, :is_active, :email, :password, :password_confirmation)
  end
end
