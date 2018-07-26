# frozen_string_literal: true

# Module for all user functions
module Users
  # Class for the controller
  class UsersController < ApplicationController
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
        if user_signed_in?
          redirect_to users_profile_path current_user.username
        else
          flash[:alert] = 'Sign in to view your page'
          redirect_to root_path
        end
        return
      end

      @user = if user_signed_in?
                User.get_users(current_user).find_by(username: username)
              else
                User.all.find_by(username: username)
              end

      return unless @user.nil?
      flash[:alert] = "User with #{username} does not exist"
      redirect_to root_path
    end

    def slashprofile
      if user_signed_in?
        redirect_to users_profile_path current_user.username
      else
        flash[:alert] = 'Sign in to view your page'
        redirect_to root_path
      end
    end

    # POST /users/profile
    # This updates the users bio
    def update
      bio = user_params[:bio]

      if bio.blank?
        flash[:alert] = 'Bio cannot be blank'
        redirect_to users_profile_path current_user.username
        return
      end

      current_user.bio = bio
      current_user.save
      flash[:notice] = 'Bio has been updated'
      redirect_to users_profile_path current_user.username
    end

    private

    # TODO: Permitted params
    def user_params
      params[:user]
    end
  end
end
