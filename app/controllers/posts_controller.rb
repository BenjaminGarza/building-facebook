# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    @posts = Post.all
    @comment = Comment.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      render 'index'
    end
  end

  def likes
    @post = Post.find_by_id(params[:post_id])
    @post.update(likes_count: @post.likes_count + 1)
    Like.create(user_id: current_user.id, post_id: params[:post_id])
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
