class ApplicationController < ActionController::Base
  protect_from_forgery
end


# Extension function to check if it is a string
class String
  def integer?
    to_i.to_s == self
  end
end