require 'rails_helper'

RSpec.describe Friend, type: :model do
  before :each do
    @user = User.create(name: 'ben', email: 'ben@gmail.com', password: '123456', password_confirmation: '123456')
    @user2 = User.create(name: 'tom', email: 'tom@gmail.com', password: '123456', password_confirmation: '123456')
    @friend = Friend.new(sender_id: @user.id, receiver_id: @user2.id)
    @friend2 = Friend.new(receiver_id: @user2.id)
    @friend3 = Friend.new(sender_id: @user.id)
  end

  it 'is valid friend request' do
    expect(@friend).to be_valid
  end

  it 'is invalid without sender id' do
    expect(@friend2).to_not be_valid
  end

  it 'is invalid without receiver id' do
    expect(@friend3).to_not be_valid
  end
end
