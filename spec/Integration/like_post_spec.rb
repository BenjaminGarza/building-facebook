# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'likepost', type: :feature do
  before :each do
    @user = User.new(name: 'tom', email: 'tom@gmail.com', password: '123456', password_confirmation: '123456')
    @user.save
    @post = @user.posts.build(content: 'Hello World!')
    @post.save
  end

  scenario 'should increment the like' do
    visit root_path
    fill_in('user_email', with: 'tom@gmail.com')
    fill_in('user_password', with: '123456')
    click_button('commit')
    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('0')
    find(:xpath, "//a[contains(@href,'/likes/')]").click
    expect(page).to have_content('1')
    find(:xpath, "//a[contains(@href,'/likes/')]").click
    expect(page).to have_content('0')
  end
end
