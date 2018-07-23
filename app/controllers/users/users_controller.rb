# frozen_string_literal: true

class Users::UsersController < ApplicationController
  # GET /users/search/:id
  def search
    id = params[:id]
    if id.blank?
      flash[:alert] = 'Search cannot be empty'
      redirect_to root_path
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

  # GET /users/profile/:username
  def profile
    username = params[:username]
    if username.blank?
      flash[:alert] = 'Username cannot be empty'
      redirect_to root_path
      return
    end

    @user = User.get_users(current_user).find_by(username: username)
    if @user.nil?
      flash[:alert] = "User with #{username} does not exist"
      redirect_to root_path
      return
    end
  end

  # POST /users/profile
  # This updates the users bio
  def update
    bio = user_params[:bio]
    username = user_params[:username]

    if username.blank?
      flash[:alert] = 'Username cannot be blank'
      redirect_to root_path
      return
    end

    if bio.blank?
      flash[:alert] = 'Bio cannot be blank'
      redirect_to users_profile_path username
      return
    end

    current_user.bio = bio
    current_user.save
    flash[:notice] = 'Bio has been updated'
    redirect_to users_profile_path username
  end

  private
  # TODO: Permitted params
  def user_params
    params[:user]
  end
end
