class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:profile]
  def profile
  end

  def settings
  end
end
