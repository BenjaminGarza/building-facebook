# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new

    @friends_id = Friend.select(:sender_id).where('(receiver_id = ?) AND confirmed = true', current_user.id)
    @friends_id2 = Friend.select(:receiver_id).where('(sender_id = ?) AND confirmed = true', current_user.id)
    @ids = set_ids(@friends_id, @friends_id2)
    @posts = Post.where('user_id IN(?) OR user_id = ?', @ids, current_user.id).order(created_at: :desc)
    @comment = Comment.new
  end

  def set_ids(friends_id, friends_id2)
    ids = []
    friends_id.each do |key|
      ids << key[:sender_id]
    end
    friends_id2.each do |key|
      ids << key[:receiver_id]
    end
    ids
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to request.referrer
    else
      @posts = Post.where('user_id IN(?) OR user_id = ?', @ids, current_user.id).order(:created_at)
      @comment = Comment.new
      render 'index'
    end
  end

  def likes
    @like = Like.where('user_id = ? and post_id = ?', current_user.id, params[:post_id]).first
    @post = Post.find_by_id(params[:post_id])
    if @like.nil?
      @post.update(likes_count: @post.likes_count + 1)
      Like.create(user_id: current_user.id, post_id: params[:post_id])
    else
      @post.update(likes_count: @post.likes_count - 1)
      @like.destroy
    end
    redirect_to request.referrer
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
