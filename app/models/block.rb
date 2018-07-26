class Block < ApplicationRecord
  belongs_to :user
  belongs_to :blocked, :class_name => 'User'
  validates :user, presence: true
  validates :blocked, presence: true
  validate :user_is_not_blocked

  def user_is_not_blocked
    puts "User: #{user}, Blocked: #{blocked}"
    return false if user.id == blocked.id else return true
  end
end