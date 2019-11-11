# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'signin', type: :feature do
  before :each do
    @user = User.new(name: 'tom', email: 'tom@gmail.com', password: '123456', password_confirmation: '123456')
    @user.save
  end

  scenario 'should be a valid signin' do
    visit root_path
    fill_in('user_email', with: 'tom@gmail.com')
    fill_in('user_password', with: '123456')
    click_button('commit')
    expect(page).to have_content('Signed in successfully')
  end
end
