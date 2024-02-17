class Public::PostsController < ApplicationController

def new
  @post = Post.new
end

def create
  @post = Post.new(post_params)
  @post.user_id = current_user.id
  tag_list = params[:post][:name].split(',')
  # 投稿ボタンを押下した場合
    if params[:post]
      if @post.save(context: :published)
        redirect_to post_path(@post.id), notice: "投稿を公開しました！"
      else
        @post.save_tag(tag_list)
        render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # 下書きボタンを押下した場合
    else
      if @post.save(is_draft: true)
        redirect_to user_path(current_user), notice: "投稿を下書き保存しました！"
      else
        render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
end

def index
  @posts = Post.where(status: :published)
  @tag_list = Tag.joins(:posts).where(posts: { status: 'published' }).uniq
end

def show
  @post = Post.find(params[:id])
  @post_comment = PostComment.new
  @post_tags = @post.tags
end

def edit
  @post = Post.find(params[:id])
  @tag_list = @post.tags.pluck(:name).join(',')
end

def update
  @post = Post.find(params[:id])
  @post.user_id = current_user.id
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
  @tag_list = Tag.joins(:posts).where(posts: { status: 'published' }).uniq
  @tag = Tag.find(params[:tag_id])
  @posts = @tag.posts.where(status: :published)
end



private

def post_params
  params.require(:post).permit(:user_id, :genre_id, :shop_id, :title, :content, :price, :rating, :status, :image, tag_ids: [])
end

end