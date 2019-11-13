# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'likepost', type: :feature do
  before :each do
    @user = User.new(name: 'tom', email: 'tom@gmail.com', password: '123456', password_confirmation: '123456')
    @user.save
    @user2 = User.new(name: 'ben', email: 'ben@gmail.com', password: '123456', password_confirmation: '123456')
    @user2.save
    @friend = Friend.new(sender_id: @user2.id, receiver_id: @user.id)
  end

  scenario 'should increment the notification' do
    visit root_path
    fill_in('user_email', with: 'tom@gmail.com')
    fill_in('user_password', with: '123456')
    click_button('commit')
    
  end
end
