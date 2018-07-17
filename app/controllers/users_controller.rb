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
    # TODO: finish blocked user
    if user_signed_in?
      if current_user.id == @user.id
        @posts = Post.all.where(user_id: @user.id).order(updated_at: :desc)
      elsif true # If user is friend
        @posts = Post.all.where(user_id: @user.id, visibility: 1..2).order(updated_at: :desc)
      else # redirect to login as user is blocked, show flash
        flash[:alert] = "You have been blocked by#{@user.first_name}"
        redirect_to root_page
      end
    else
      @posts = Post.all.where(user_id: @user.id, visibility: 2).order(updated_at: :desc)
    end
  end

  def settings
    redirect_to edit_user_registration_path
  end
end

class String
  def integer?
    to_i.to_s == self
  end
end
