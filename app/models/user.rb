class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :username, presence: true
  validates :date_of_birth, presence: true

  validate :username, :check_empty_spaces
  validate :date_of_birth, :age_allowed

  validates :username, uniqueness: true


  # Validators
  def check_empty_spaces
    return errors.add(:username, 'No spaces allolsaed in username') \
      if username.match?(/\s/)
  end

  def age_allowed
    return errors.add(:date_of_birth, 'You should be above 13 years old') \
      unless date_of_birth.present? && date_of_birth < 13.years.ago
  end

  # Use this instead of User.all so that users that blocked you dont show up
  def self.get_users(current_user)
    User.all
  end

end
