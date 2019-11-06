# frozen_string_literal: true

class Friend < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  validate :unique_relation, on: :create

  def unique_relation
    errors.add(:warning, 'Cannot add self as friend') if receiver_id == sender_id
    friend = Friend.where('receiver_id = (?) AND sender_id = (?)', receiver_id, sender_id).first
    friend = Friend.where('receiver_id = (?) AND sender_id = (?)', sender_id, receiver_id).first if friend.nil?
    errors.add(:warning, 'Already friends') unless friend.nil?
  end
end
