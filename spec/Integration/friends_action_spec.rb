# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'friend_request', type: :feature do
  before :each do
    @user = User.create(name: 'tom', email: 'tom@gmail.com', password: '123456', password_confirmation: '123456')
    @user2 = User.create(name: 'ben', email: 'ben@gmail.com', password: '123456', password_confirmation: '123456')
    @post = @user2.posts.build(content: 'Hello World!')
    @post.save
  end

  scenario 'should send friend request, cancel friend request, accept, and remove friend' do
    visit root_path
    fill_in('user_email', with: 'tom@gmail.com')
    fill_in('user_password', with: '123456')
    click_button('commit')
    visit profiles_path(@user2.id)
    click_link('Add as friend')
    expect(page).to have_content('Cancel request')
    click_link('Cancel request')
    expect(page).to have_content('Add as friend')
    click_link('Add as friend')
    click_link('Sign out')
    visit root_path
    fill_in('user_email', with: 'ben@gmail.com')
    fill_in('user_password', with: '123456')
    click_button('commit')
    click_link('View Profile')
    expect(page).to have_content('Accept friend')
    click_link('Accept friend')
    expect(page).to have_content('Remove friend')
    click_link('Remove friend')
    visit profiles_path(@user.id)
    expect(page).to have_content('tom')
    expect(page).to have_content('Add as friend')
  end

  scenario 'should ignore friend request' do
    visit root_path
    fill_in('user_email', with: 'tom@gmail.com')
    fill_in('user_password', with: '123456')
    click_button('commit')
    visit profiles_path(@user2.id)
    click_link('Add as friend')
    expect(page).to have_content('Cancel request')
    click_link('Cancel request')
    expect(page).to have_content('Add as friend')
    click_link('Add as friend')
    click_link('Sign out')
    visit root_path
    fill_in('user_email', with: 'ben@gmail.com')
    fill_in('user_password', with: '123456')
    click_button('commit')
    click_link('View Profile')
    expect(page).to have_content('tom')
    expect(page).to have_content('Ignore friend')
    click_link('Ignore friend')
    expect(page).to_not have_content('tom')
  end

  scenario 'should ignore friend request' do
    visit root_path
    fill_in('user_email', with: 'tom@gmail.com')
    fill_in('user_password', with: '123456')
    click_button('commit')
    expect(page).to_not have_content('Hello World!')
    visit profiles_path(@user2.id)
    click_link('Add as friend')
    click_link('Sign out')
    visit root_path
    fill_in('user_email', with: 'ben@gmail.com')
    fill_in('user_password', with: '123456')
    click_button('commit')
    click_link('View Profile')
    expect(page).to have_content('tom')
    click_link('Accept friend')
    click_link('Sign out')
    fill_in('user_email', with: 'tom@gmail.com')
    fill_in('user_password', with: '123456')
    click_button('commit')
    expect(page).to have_content('Hello World!')
  end
end
