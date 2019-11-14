# frozen_string_literal: true

FactoryGirl.define do
  factory :post do
    content 'MyText'
    likes_count 1
    user_id 1
  end
end
