# frozen_string_literal: true

# Model for Users
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable


  # Blocked users
  has_many :blocks, dependent: :destroy
  has_many :users_that_blocked_me, through: :blocks, source: :user
  has_many :users_i_blocked, through: :blocks, source: 'blocked'

  # Post
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :username, presence: true
  validates :date_of_birth, presence: true

  validates_format_of :username, with: /\A[a-z]+\z/i,\
                                 message: 'can only contain letters'
  validate :date_of_birth, :age_allowed

  validates :username, uniqueness: true
  validates :terms_of_service, acceptance: { message: 'must be abided' }


  # Validators
  def age_allowed
    return errors.add(:date_of_birth, 'You should be above 13 years old') \
      unless date_of_birth.present? && date_of_birth < 13.years.ago
  end

  # Use this instead of User.all so that users that blocked you don't show up
  def self.get_users(current_user)
    return User.all.where.not(confirmed_at: nil) if current_user.nil?
    blocks = Block.all
    c_userid = current_user.id
    ids = blocks.where(user_id: c_userid).map(&:blocked_id)
    ids += blocks.where(blocked_id: c_userid).map(&:user_id)
    User.all.where.not(id: ids)
  end
end
