# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %I[show edit update destroy followings followers]

  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  # フォロー一覧
  def followings
    @followings = @user.following_users
  end

  # フォロワー一覧
  def followers
    @followers = @user.follower_users
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
