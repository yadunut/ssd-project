# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
end

class String
  def integer?
    to_i.to_s == self
  end
end
