class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @requests = User.where("id in(?)", Friend.select(:sender_id).where('receiver_id = ? AND confirmed = false', current_user.id))
    @sender = Friend.where("receiver_id = ? AND sender_id = ?", @user.id,current_user.id).first
    @receiver = Friend.where("receiver_id = ? AND sender_id = ?", current_user.id, @user.id).first
  end

  def add
    Friend.create(sender_id: current_user.id,receiver_id: params[:friend_id], confirmed: false)
    redirect_to profiles_path(params[:friend_id])
  end
end
