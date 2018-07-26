# frozen_string_literal: true

# Controller which handles the posts
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: :destroy
  before_action :set_comment, only: :destroy_comment
  before_action :set_users, only: :index

  # GET /posts
  def index
    @posts = Post.all.where(user_id: @users.map)\
                 .order(updated_at: :desc).map do |post|
      if (current_user.id == post.user_id) || ([1, 2].include? post.visibility)
        post
      end
    end.compact
    @post = Post.new if @post.nil?
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    flash[:notice] = 'Post was successfully created.' if @post.save
    redirect_to posts_url
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    unless @post.user_id == current_user.id
      flash[:error] = 'You cannot delete this post'
      redirect_to posts_url
    end

    @post.destroy
    flash[:notice] = 'Post was successfully deleted.'
    redirect_to posts_url
  end

  # POST /comments
  def create_comment
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    flash[:notice] = 'Comment was successfully created.' if @comment.save
    redirect_to posts_url
  end

  # DELETE /comments/1
  def destroy_comment
    unless @comment.user_id == current_user.id
      flash[:error] = 'You cannot delte this comment'
      redirect_to posts_url
    end

    @comment.destroy
    flash[:notice] = 'Comment was successfully deleted'
    redirect_to posts_url
  end

  private

  def set_users
    @users = User.get_users(current_user)
  end

  def set_post
    @post = Post.find(params[:id])
    return unless @post.nil?
    flash[:alert] = 'Post cannot be nil'
    redirect_to root_path
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white
  # list through.
  def post_params
    params.require(:post).permit(:body, :visibility)
  end

  def comment_params
    params.permit(:body, :post_id)
  end
end
