# frozen_string_literal: true

class Block < ApplicationRecord
  belongs_to :user
  belongs_to :blocked, class_name: 'User'

  validates :user, presence: true
  validates :blocked, presence: true
  validates :blocked, uniqueness: {scope: :user, message: 'no duplicate blocks allowed'}

  validate :user_is_not_blocked

  # Validates user != blocked, i.e user cannot block themselves
  def user_is_not_blocked
    return errors.add(:user, 'You cannot block yourself')\
    if user_id == blocked_id
  end
end
