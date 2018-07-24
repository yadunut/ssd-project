# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  validates :body, presence: true
  validates :user, presence: true
  validates_inclusion_of :visibility, in: [1, 2, 3]
end
