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
    click_link('Add friend')
    expect(page).to have_content('Cancel request')
    click_link('Cancel request')
    expect(page).to have_content('Add friend')
    click_link('Add friend')
    click_link('f-sing-out')
    visit root_path
    fill_in('user_email', with: 'ben@gmail.com')
    fill_in('user_password', with: '123456')
    click_button('commit')
    click_link('Ben', match: :first)
    visit requests_path(@user2.id)
    expect(page).to have_content('Accept')
    click_link('Accept')
    expect(page).to have_content('Remove')
    click_link('Remove')
    visit profiles_path(@user.id)
    expect(page).to have_content('Tom')
    expect(page).to have_content('Add friend')
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
    expect(page).to have_content('Add friend')
    click_link('Add friend')
    click_link('f-sing-out')
    visit root_path
    fill_in('user_email', with: 'ben@gmail.com')
    fill_in('user_password', with: '123456')
    click_button('commit')
    click_link('Ben', match: :first)
    expect(page).to have_content('Tom')
    expect(page).to have_content('Ignore')
    click_link('Ignore friend')
    expect(page).to_not have_content('Tom')
  end

  scenario 'should ignore friend request' do
    visit root_path
    fill_in('user_email', with: 'tom@gmail.com')
    fill_in('user_password', with: '123456')
    click_button('commit')
    expect(page).to_not have_content('Hello World!')
    visit profiles_path(@user2.id)
    click_link('Add friend')
    click_link('f-sing-out')
    visit root_path
    fill_in('user_email', with: 'ben@gmail.com')
    fill_in('user_password', with: '123456')
    click_button('commit')
    click_link('Ben', match: :first)
    expect(page).to have_content('Tom')
    click_link('Accept')
    click_link('f-sing-out')
    fill_in('user_email', with: 'tom@gmail.com')
    fill_in('user_password', with: '123456')
    click_button('commit')
    expect(page).to have_content('Hello World!')
  end
end
