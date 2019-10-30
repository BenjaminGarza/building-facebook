# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      render 'index'
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
