class Comment < ApplicationRecord
  audited
  belongs_to :user
  belongs_to :post

  validates :body, presence: true
  validates :post, presence: true
  validates :user, presence: true
end
