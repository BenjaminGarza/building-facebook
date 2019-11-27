# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @sender = Friend.where('receiver_id = ? AND sender_id = ?', @user.id, current_user.id).first
    @receiver = Friend.where('receiver_id = ? AND sender_id = ?', current_user.id, @user.id).first
    @posts = Post.where('user_id IN(?)', @user.id).order(created_at: 'DESC')
    @comment = Comment.new
    @post = Post.new
  end

  def posts
    @user = User.find(params[:id])
    @posts = Post.where('user_id IN(?)', @user.id).order(created_at: 'DESC')
    @comment = Comment.new
    @post = Post.new
  end

  def friends
    @user = User.find(params[:id])
    @ids = create_friends_ids(params[:id])
    @friends = User.where('id IN (?)', @ids)
  end

  def requests
    @user = User.find(params[:id])
    @user_ids = Friend.select(:sender_id).where('receiver_id = ? AND confirmed = false', current_user.id)
    @requests = User.where('id in(?)', @user_ids)
  end

  def create_friends_ids(id)
    @friends_id = Friend.select(:sender_id).where('(receiver_id = ?) AND confirmed = true', id)
    @friends_id2 = Friend.select(:receiver_id).where('(sender_id = ?) AND confirmed = true', id)
    set_ids(@friends_id, @friends_id2)
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

  def add
    @user = User.find(params[:friend_id])
    @sender = Friend.where('receiver_id = ? AND sender_id = ?', @user.id, current_user.id).first
    @receiver = Friend.where('receiver_id = ? AND sender_id = ?', current_user.id, @user.id).first
<<<<<<< HEAD
    return unless @sender.nil? || @receiver.nil?
    Friend.create(sender_id: current_user.id, receiver_id: params[:friend_id], confirmed: false)
    @sender = Friend.where('receiver_id = ? AND sender_id = ?', @user.id, current_user.id).first
    @receiver = Friend.where('receiver_id = ? AND sender_id = ?', current_user.id, @user.id).first
=======
    if @sender.nil? || @receiver.nil?
      Friend.create(sender_id: current_user.id, receiver_id: params[:friend_id], confirmed: false)
      @sender = Friend.where('receiver_id = ? AND sender_id = ?', @user.id, current_user.id).first
      @receiver = Friend.where('receiver_id = ? AND sender_id = ?', current_user.id, @user.id).first
    end
>>>>>>> 591dd38043900d765d71eea2b7b50216f380773e
  end

  def index
    @friends_id3 = Friend.select(:sender_id).where('(receiver_id = ?) AND confirmed = true', current_user.id)
    @friends_id4 = Friend.select(:receiver_id).where('(sender_id = ?) AND confirmed = true', current_user.id)
    @ids2 = set_ids(@friends_id3, @friends_id4)
    @ids2 << current_user.id
    @not_friends = User.where('id NOT IN (?)', @ids2)
    @not_friends = User.all if @not_friends.empty?
  end
end
