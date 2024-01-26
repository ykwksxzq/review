class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  
  
end
