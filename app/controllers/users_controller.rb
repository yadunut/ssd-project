# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:profile]

  # GET :id shows search results
  def profile_search
    id = params[:id]
    @users = if id.integer?
               User.where(id: id)
             else
               id.downcase!
               User.where('lower(username) LIKE ? or lower(first_name) LIKE ? or lower(last_name) LIKE ?', "%#{id}%", "%#{id}%", "%#{id}%")
             end
    @users.each do |u|
      puts u.username
    end
  end

  # GET :id/profile
def profile
    id = params[:id]
    begin
      @user = User.find(id)
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'User not found'
      redirect_to root_path
      return
    end

  end

  def settings
    redirect_to edit_user_registration_path
  end

  # Shows posts based on visibility
  # 1 means only I can see
  # 2 only unblocked people can see
  # 3 everyone can see
  def get_posts(user)
    # Visibility 1
    if user.id == current_user.id
      return user.posts.all.order updated_at: :desc
    end

    # Visibility 2

    # If this is true, current user is blocked
    if current_user.in?(user.users_i_blocked)
      return nil
    end



  end

end
