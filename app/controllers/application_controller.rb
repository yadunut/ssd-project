# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery

  # Redirect hook
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      puts "Resource is Admin"
      admin_root_path_url
    when User
      puts "Resource is User"
      super
    else
      super
    end
  end
end

# Extension function to check if it is a string
class String
  def integer?
    to_i.to_s == self
  end
end
