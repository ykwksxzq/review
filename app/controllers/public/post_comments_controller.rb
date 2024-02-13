class Public::PostCommentsController < ApplicationController

def create
  @post = Post.find(params[:post_id])
  content = current_user.post_comments.new(post_comment_params)
  content.post_id = @post.id
  content.save
  redirect_to post_path(@post.id)
end

private

def post_comment_params
  params.require(:post_comment).permit(:user_id, :post_id, :content)
end


end