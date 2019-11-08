# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'signin', type: :feature do
  before :each do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user] # If using Devise
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
  end

  scenario 'should be a valid signin' do
    visit root_path
    click_link('Sign in with Facebook')
    expect(page).to have_content('Successfully authenticated from Facebook account.')
  end
end
