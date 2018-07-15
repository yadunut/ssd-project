class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :delete_all
  validates :body, presence: true
  
end
