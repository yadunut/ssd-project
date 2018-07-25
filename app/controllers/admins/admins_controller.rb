# frozen_string_literal: true

# Admins Module handles all actions for admins
module Admins
  # AdminsController is the controller for admin actions
  class AdminsController < ApplicationController
    before_action :authenticate_admin!
    def index
      @users = User.all
    end

    def destroy_user
      id = params[:id]
      if id.blank?
        flash[:alert] = 'id cannot be empty'
        redirect_to root_path
        return
      end

      user = User.find(id)
      if user.blank?
        flash[:alert] = 'user not found'
        redirect_to root_path
        return
      end

      user.destroy
      redirect_to root_path
    end
  end
end
