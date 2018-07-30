# frozen_string_literal: true

# The post model
class Post < ApplicationRecord
  audited
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :body, presence: true
  validates :user, presence: true
  validates :visibility, presence: true
  validates_inclusion_of :visibility, in: [0, 1, 2]
end
