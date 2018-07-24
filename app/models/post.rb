# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :body, presence: true
  validates :user, presence: true
  validates :visibility, presence: true
  validates_inclusion_of :visibility, in: [0, 1, 2]
end
