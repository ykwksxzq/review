class Public::PostsController < ApplicationController

def new
  @post = Post.new
end

def create
  @post = Post.new(post_params)
  @post.user_id = current_user.id

  tag_list = params[:post][:name].split(',')
  if @post.save
    @post.save_tag(tag_list)
    redirect_to post_path(@post.id)
  else
    render :new
  end
end

def index
  @posts = Post.all
  @tag_list = Tag.all
end

def show
  @post = Post.find(params[:id])
  @post_comment = PostComment.new
  @post_tags = @post.tags
end

def edit
  @post = Post.find(params[:id])
  @tag_list=@post.tags.pluck(:name).join(',')
end

def update
  @post = Post.find(params[:id])

  tag_list = params[:post][:name].split(',')
  @post.save_tag(tag_list)
  if @post.update(post_params)
     redirect_to post_path(@post.id)
  else
    render :edit
  end
end

def destroy
  @post = Post.find(params[:id])
  @post.destroy
  redirect_to posts_path
end

def search_tag
  @tag_list=Tag.all
  @tag=Tag.find(params[:tag_id])
  @posts=@tag.posts
end



private

def post_params
  params.require(:post).permit(:user_id, :genre_id, :shop_id, :title, :content, :price, :rating, :status, :image, tag_ids: [])
end



end
