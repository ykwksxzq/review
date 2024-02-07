class Public::PostsController < ApplicationController

def new
  @post = Post.new
end

def create
  @post = Post.new(post_params)
  @post.user_id = current_user.id

  tag_list = params[:post][:title].split(',')
  if @post.save
    @post.save_tag(tag_list)
    redirect_to post_path(@post.id)
  else
    render :new
  end
end

def index
  @posts = Post.all
end





private

def post_params
  params.require(:post).permit(:user_id, :genre_id, :shop_id, :title, :content, :price, :rating, :status, :image)
end



end
