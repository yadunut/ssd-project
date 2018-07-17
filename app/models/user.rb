# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :delete_all

  validates :first_name, presence: true
  validate :validate_age
  validates :username, presence: true

  private

  def validate_age
    return false if date_of_birth.present? && date_of_birth < 13.years.ago
    errors.add(:date_of_birth, 'You should be over 13 years old.')
  end
end
