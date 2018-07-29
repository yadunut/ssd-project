# frozen_string_literal: true

class Users::BlocksController < ApplicationController
  before_action :set_users_block, only: [:destroy]
  before_action :authenticate_user!

  # GET /users/blocks
  # GET /users/blocks.json
  def index
    @users_blocks = Block.all.where(user_id: current_user.id)
  end

  # GET /users/blocks/new
  def new
    @users_block = Block.new
    @users = get_blockable_users
    if @users.empty?
      flash[:notice] = 'You have blocked all users'
      redirect_to block_path
    end
  end

  # POST /users/blocks
  # POST /users/blocks.json
  def create
    @users_block = Block.new(blocked_id: params[:block][:blocked],
                             user_id: current_user.id)
    @users = get_blockable_users

    respond_to do |format|
      if @users_block.save
        format.html { redirect_to block_path, notice: 'Block was successfully created.' }
        format.json { render :show, status: :created, location: @users_block }
      else
        format.html { render :new }
        format.json { render json: @users_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/blocks/1
  # DELETE /users/blocks/1.json
  def destroy
    @users_block.destroy
    respond_to do |format|
      format.html { redirect_to block_path, notice: 'Block was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_users_block
    @users_block = Block.find(id_params)
  end

  def id_params
    params.permit(:id)
  end

  def get_blockable_users
    ids = Block.all.where(user_id: current_user.id).map(&:blocked_id)
    ids.push(current_user.id)
    User.all.where.not(id: ids)
  end

end
