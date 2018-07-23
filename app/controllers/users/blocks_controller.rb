# frozen_string_literal: true

class Users::BlocksController < ApplicationController
  before_action :set_users_block, only: [:destroy]
  before_action :authenticate_user!

  # GET /users/blocks
  # GET /users/blocks.json
  def index
    @users_blocks = Users::Block.all
  end

  # GET /users/blocks/new
  def new
    @users_block = Users::Block.new
    @users = Users.get_users(current_user)
  end

  # POST /users/blocks
  # POST /users/blocks.json
  def create
    @users_block = Users::Block.new(users_block_params)
    @users_block.user = current_user

    respond_to do |format|
      if @users_block.save
        format.html { redirect_to @users_block, notice: 'Block was successfully created.' }
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
      format.html { redirect_to users_blocks_url, notice: 'Block was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_users_block
    @users_block = Users::Block.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def users_block_params
    params.fetch(:users_block, {}).permit(:blocked)
  end
end
