# frozen_string_literal: true

class Users::UsersController < ApplicationController
  def search
    id = params[:id]
    if id.blank?
      redirect_to root_path
      flash[:alert] = 'Search cannot be empty'
      return
    end
    users = if user_signed_in?
              User.get_users(current_user)
            else
              User.all
            end
    @users = users
             .where('lower(name) LIKE ?', "%#{id.downcase}%")
             .or(users.where('lower(username) LIKE ?', "%#{id.downcase}%"))
             .or(users.where('lower(email) LIKE ?', "%#{id.downcase}%"))
  end

  def profile; end
end
