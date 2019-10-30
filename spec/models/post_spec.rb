# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  before :each do
    @user = User.new(name: 'tom', email: 'tom@gmail.com', password: '123456', password_confirmation: '123456')
    @user.save
    @post = @user.posts.build('Hello World!')
  end

  it 'is valid post' do
    expect(@post).to be_valid
  end

  it 'is not a valid post' do
    @post.user_id = nil
    expect(@post).to_not be_valid
  end
end
