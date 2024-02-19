class Public::GenresController < ApplicationController

  def index
    @genre = Genre.find(params[:genre_id])
    @genres = Genre.all

   if params[:genre_id].present?
     @genre = Genre.find(params[:genre_id])
     @posts = @genre.posts
     @posts = @posts.published
   end
  end

  private

  def genre_prarms
   params.require(:genre).permit(:name)
  end

end
