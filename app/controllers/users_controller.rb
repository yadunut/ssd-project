# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:profile]

  # GET /:id shows search results
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

  def profile
    id = params[:id]
    begin
      @user = User.find(id)
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'User not found'
      redirect_to root_path
      return
    end
    @posts =  if user_signed_in? 
                if current_user.id == @user.id
                  Post.all.where(user_id: @user.id).order(updated_at: :desc)
                else 
                  Post.all.where(user_id: @user.id, visibility: 1..2).order(updated_at: :desc)
                end
              else 
                Post.all.where(user_id: @user.id, visibility: 2).order(updated_at: :desc)
              end
  end

  def settings; end
end

class String
  def integer?
    to_i.to_s == self
  end
end
