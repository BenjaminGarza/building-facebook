# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    @user = User.new(name: 'tom', email: 'tom@gmail.com', password: '123456', password_confirmation: '123456')
    @user.save
    @post = @user.posts.build(content: 'Hello World!')
    @post.save
    @comment = @user.comments.build(content: 'Hello!', post_id: @post.id)
    @comment_no_user = Comment.new(content: 'Hello!', post_id: @post.id)
    @comment_no_post = Comment.new(content: 'Hello!', user_id: @user.id)
  end

  it 'is valid comment' do
    expect(@comment).to be_valid
  end

  it 'is not a valid comment without content' do
    @comment.content = ''
    expect(@comment).to_not be_valid
  end

  it 'is not a valid comment without user id' do
    expect(@comment_no_user).to_not be_valid
  end

  it 'is not a valid comment without post id' do
    expect(@comment_no_post).to_not be_valid
  end
end
