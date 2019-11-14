# frozen_string_literal: true

class FriendsController < ApplicationController
  def cancel
    @friend = Friend.where('sender_id = ? AND receiver_id = ?', current_user.id, params[:friend_id]).first
    @friend&.destroy
    redirect_to profiles_path(params[:friend_id])
  end

  def ignore
    @friend = Friend.where('sender_id = ? AND receiver_id = ?', params[:friend_id], current_user.id).first
    @friend&.destroy
    redirect_to profiles_path(current_user.id)
  end

  def accept
    @friend = Friend.where('sender_id = ? AND receiver_id = ?', params[:friend_id], current_user.id).first
    if @friend.nil?
      flash[:warning] = 'Sorry, this request is no longer valid.'
    else
      @friend.update(confirmed: true)
    end
    redirect_to profiles_path(current_user.id)
  end

  def add
    @friend = Friend.where('receiver_id = ? AND sender_id = ?', current_user.id, params[:friend_id]).first
    Friend.create(sender_id: current_user.id, receiver_id: params[:friend_id], confirmed: false) if @friend.nil?
    redirect_to profiles_path(params[:friend_id])
  end

  def remove
    @friend = Friend.where('sender_id = ? AND receiver_id = ?', params[:friend_id], current_user.id).first
    if @friend.nil?
      @friend = Friend.where('sender_id = ? AND receiver_id = ?', current_user.id, params[:friend_id]).first
    end
    @friend&.destroy
    redirect_to profiles_path(params[:friend_id])
  end

  def notify
    @notifications = Friend.where('created_at = updated_at AND receiver_id = ?', current_user.id).count
    respond_to do |format|
      format.html
      format.js {}
      format.json do
        render json: { notifications: @notifications }
      end
    end
  end
end
