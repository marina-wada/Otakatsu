class User::GenresController < ApplicationController
  before_action :authenticate_user!

  def new
    @genres = current_user.genres
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to new_item_path(@genre.id)
    else
      @genres = current_user.genres
      render :new
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end

end
