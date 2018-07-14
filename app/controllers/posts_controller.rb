# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!

  # GET /posts
  def index
    @posts = Post.all.order updated_at: :desc
    @post = Post.new
  end

  # POST /posts
  def create
    body = params['post']['body']
    if body.blank?
      # Show error to user
      redirect_to root_path
      return
    end

    p = Post.new
    p.body = body
    p.user_id = current_user.id
    p.name = "#{current_user.first_name} #{current_user.last_name}"
    if p.invalid?
      # Show error to user
      redirect_to root_path
      return
    end
    p.save
    redirect_to root_path
  end

end
