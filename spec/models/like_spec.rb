# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @user = User.new(name: 'tom', email: 'tom@gmail.com', password: '123456', password_confirmation: '123456')
    @user.save
    @post = @user.posts.build(content: 'Hello World!')
    @post.save
    @like = Like.new(user_id: @user.id, post_id: @post.id)
    @like_no_user = Like.new(post_id: @post.id)
    @like_no_post = Like.new(user_id: @user.id)
  end

  it 'is valid like' do
    expect(@like).to be_valid
  end

  it 'is not a valid like without user id' do
    expect(@like_no_user).to_not be_valid
  end

  it 'is not a valid post without post id' do
    expect(@like_no_post).to_not be_valid
  end
end
