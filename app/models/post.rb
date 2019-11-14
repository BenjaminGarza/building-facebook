# frozen_string_literal: true

class Post < ApplicationRecord
  after_create :set_likes

  belongs_to :user
  has_many :comments
  has_many :likes
  validates :content, presence: true

  def set_likes
    update_attribute(:likes_count, 0)
  end
end
