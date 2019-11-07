# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'signin', type: :feature do
  before :each do
    @user = User.new(name: 'tom', email: 'tom@gmail.com', password: '123456', password_confirmation: '123456')
    @user.save
    OmniAuth.config.mock_auth[:facebook] = nil
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
  Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  scenario 'should be a valid signin' do
    visit root_path
    expect(page).to have_content('Sign in with Facebook')
    click_link('Sign in with Facebook')
    fill_in('email', with: 'tom@gmail.com')
    fill_in('pass', with: '123456')
    click_button('loginbutton')
  end
end
