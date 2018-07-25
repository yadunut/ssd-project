# frozen_string_literal: true

# ApplicationController is the root controller which all others extend from
class ApplicationController < ActionController::Base
  protect_from_forgery

  # Redirect hook
end

# Extension function to check if it is a string
class String
  def integer?
    to_i.to_s == self
  end
end
