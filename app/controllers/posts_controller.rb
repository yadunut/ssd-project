# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!

  # GET /posts
  def index
    @posts = Post.all.order updated_at: :desc
    @comments = Comment.all.order updated_at: :asc
    @users = User.all
  end

  # POST /posts
  def create_post
    body = params['body']
    if body.blank?
      flash[:notice] = 'Post cannot be empty'
      redirect_to root_path
      return
    end
    p = Post.new
    p.body = body
    p.user_id = current_user.id
    visibility = params[:visibility]
    unless visibility.integer?
      flash[:alert] = 'Visibility is invalid'
      redirect_to root_path
      return
    end

    p.visibility = visibility.to_i
    if p.invalid?
      flash[:alert] = 'Post is invalid'
      redirect_to root_path
      return
    end
    p.save
    redirect_to root_path
  end

  # POST /comment
  def create_comment
    body = params['body']
    if body.blank?
      flash[:notice] = 'Comment cannot be empty'
      redirect_to root_path
      return
    end

    c = Comment.new
    c.post_id = params['id']
    c.user_id = current_user.id
    c.body = body
    if c.invalid?
      flash[:alert] = 'Error in posting comment'
      redirect_to root_path
      return
    end
    c.save
    redirect_to root_path
  end
end
