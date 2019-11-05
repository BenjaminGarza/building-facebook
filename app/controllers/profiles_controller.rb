class ProfilesController < ApplicationController
  def show
    @ids = []
    @friends_id = Friend.select(:sender_id).where("(receiver_id = ?) AND confirmed = true",params[:id] )
    @friends_id2 = Friend.select(:receiver_id).where("(sender_id = ?) AND confirmed = true",params[:id] )
    @friends_id.each do |key| 
        @ids << key[:sender_id]
    end
    @friends_id2.each do |key| 
        @ids << key[:receiver_id]
    end
    @friends = User.where("id IN (?)", @ids)
    @user = User.find(params[:id])
    @requests = User.where("id in(?)", Friend.select(:sender_id).where('receiver_id = ? AND confirmed = false', current_user.id))
    @sender = Friend.where("receiver_id = ? AND sender_id = ?", @user.id,current_user.id).first
    @receiver = Friend.where("receiver_id = ? AND sender_id = ?", current_user.id, @user.id).first
  end

  def add
    @friend = Friend.where("receiver_id = ? AND sender_id = ?", current_user.id, params[:friend_id]).first
    Friend.create(sender_id: current_user.id,receiver_id: params[:friend_id], confirmed: false) if @friend.nil?
    redirect_to profiles_path(params[:friend_id])
  end
end
