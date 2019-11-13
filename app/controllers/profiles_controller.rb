# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @friends_id = Friend.select(:sender_id).where('(receiver_id = ?) AND confirmed = true', params[:id])
    @friends_id2 = Friend.select(:receiver_id).where('(sender_id = ?) AND confirmed = true', params[:id])
    @ids = set_ids(@friends_id, @friends_id2)
    @friends = User.where('id IN (?)', @ids)
    @user = User.find(params[:id])
    @user_ids = Friend.select(:sender_id).where('receiver_id = ? AND confirmed = false', current_user.id)
    @requests = User.where('id in(?)', @user_ids)
    @sender = Friend.where('receiver_id = ? AND sender_id = ?', @user.id, current_user.id).first
    @receiver = Friend.where('receiver_id = ? AND sender_id = ?', current_user.id, @user.id).first
    @posts = Post.where('user_id IN(?)', @user.id).order(:created_at)
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

  def index
    @friends_id3 = Friend.select(:sender_id).where('(receiver_id = ?) AND confirmed = true', current_user.id)
    @friends_id4 = Friend.select(:receiver_id).where('(sender_id = ?) AND confirmed = true', current_user.id)
    @ids2 = set_ids(@friends_id3, @friends_id4)
    @ids2 << current_user.id
    @not_friends = User.where('id NOT IN (?)', @ids2)
    @not_friends = User.all if @not_friends.empty?
  end
end
