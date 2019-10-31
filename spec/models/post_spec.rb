# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = User.new(name: 'tom', email: 'tom@gmail.com', password: '123456', password_confirmation: '123456')
    @user.save
    @post = @user.posts.build(content: 'Hello World!')
    @post2 = Post.new
  end

  it 'is valid post' do
    expect(@post).to be_valid
  end

  it 'is not a valid post without user id' do
    @post2.content = 'Invalid'
    expect(@post2).to_not be_valid
  end

  it 'is not a valid post without content' do
    @post.content = ''
    expect(@post).to_not be_valid
  end
end
