# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    # @user = User.find(params[:id])
    redirect_to current_user
  end
end
