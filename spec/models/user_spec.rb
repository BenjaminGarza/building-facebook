# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(name: 'tom', email: 'tom@gmail.com', password: '123456', password_confirmation: '123456')
    @user.save
  end

  it 'is valid user' do
    expect(@user).to be_valid
  end

  it 'is not a valid email' do
    @user.email = 'tomgmail.com'
    expect(@user).to_not be_valid
  end

  it 'email should be unique' do
    @user2 = User.new(name: 'tom', email: 'tom@gmail.com', password: '123456', password_confirmation: '123456')
    expect(@user2).to_not be_valid
  end

  it 'is not a valid password' do
    @user.password = '12345'
    @user.password_confirmation = '12345'
    expect(@user).to_not be_valid
  end

  it 'is not a valid confirmation password' do
    @user.password = '123456'
    @user.password_confirmation = '123457'
    expect(@user).to_not be_valid
  end

  it 'is not a valid name' do
    @user.name = ''
    expect(@user).to_not be_valid
  end
end
