# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'signup', type: :feature do
  scenario 'should be a valid signup link' do
    visit root_path
    click_link('Sign up')
    expect(page).to have_content('Sign up')
  end

  scenario 'should be a valid signup' do
    visit root_path
    click_link('Sign up')
    expect(page).to have_content('Password confirmation')
    fill_in('user_name', with: 'tom')
    fill_in('user_email', with: 'tom@gmail.com')
    fill_in('user_password', with: '123456')
    fill_in('user_password_confirmation', with: '123456')
    click_button('commit')
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'should be an invalid signup' do
    @user = User.create(name: 'tom', email: 'tom@gmail.com', password: '123456', password_confirmation: '123456')

    visit root_path
    click_link('Sign up')
    expect(page).to have_content('Password confirmation')
    fill_in('user_name', with: 'tom')
    fill_in('user_email', with: 'tom@gmail.com')
    fill_in('user_password', with: '123456')
    fill_in('user_password_confirmation', with: '123456')
    click_button('commit')
    expect(page).to have_content('Email has already been taken')
  end
end
