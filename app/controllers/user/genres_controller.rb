class User::GenresController < ApplicationController
  before_action :authenticate_user!

  def new
    @genres = current_user.genres.uniq
    @genre = Genre.new
  end

  def create
    @genre = Genre.find_or_create_by(name: params[:genre][:name])
    if !@genre.id.nil?
      redirect_to new_item_path(@genre.id)
    else
      @genres = current_user.genres
      flash.now[:alert] = "作品名・イベント名を入力してください"
      render :new
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:success] = '更新が完了しました'
      redirect_to edit_genre_path(@genre.id)
    else
      flash.now[:alert] = '更新に失敗しました'
      render :edit
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end

end
