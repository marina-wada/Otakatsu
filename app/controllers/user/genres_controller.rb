class User::GenresController < ApplicationController
  before_action :authenticate_user!

  def new
    @genres = current_user.genres.uniq
    @genre = Genre.new
  end

  def create
    @genre = Genre.find_or_create_by(name: params[:genre][:name])
    if @genre
      redirect_to new_item_path(@genre.id)
    else
      @genres = current_user.genres
      render :new
    end
  end

  def edit
    @genre = Genre.find_by(params[:name])
    @genres = current_user.genres
  end

  def update
    @genre = Genre.find_by(params[:name])
    @genre.update(genre_params)
    redirect_to new_genre_path
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end

end
