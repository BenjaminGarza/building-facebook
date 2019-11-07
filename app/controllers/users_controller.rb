# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    # @user = User.find(params[:id])
    redirect_to current_user
  end
end
