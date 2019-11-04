class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @requests = User.where("id in(?)", Friend.select(:sender_id).where('receiver_id = ?', current_user.id))
  end

  def add
    Friend.create(sender_id: current_user.id,receiver_id: params[:friend_id], confirmed: false)
    redirect_to profiles_path(params[:friend_id])
  end
end
