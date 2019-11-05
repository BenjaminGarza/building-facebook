class FriendsController < ApplicationController
  def cancel
    @friend = Friend.where("sender_id = ? AND receiver_id = ?", current_user.id, params[:friend_id]).first
    @friend.destroy unless @friend.nil?
    redirect_to profiles_path(params[:friend_id])
  end

  def ignore
    @friend = Friend.where("sender_id = ? AND receiver_id = ?", params[:friend_id], current_user.id).first
    @friend.destroy unless @friend.nil?
    redirect_to profiles_path(current_user.id)
  end

  def accept
    @friend = Friend.where("sender_id = ? AND receiver_id = ?", params[:friend_id], current_user.id).first
    unless @friend.nil?
      @friend.update(confirmed: true)
    else
      flash[:warning] = "Sorry, this request is no longer valid."
    end
    redirect_to profiles_path(current_user.id)
  end

  def remove
    @friend = Friend.where("sender_id = ? AND receiver_id = ?", params[:friend_id], current_user.id).first
    @friend = Friend.where("sender_id = ? AND receiver_id = ?", current_user.id, params[:friend_id]).first if @friend.nil?
    @friend.destroy unless @friend.nil?
    redirect_to profiles_path(params[:friend_id])
  end
end
