# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
<<<<<<< HEAD
=======
  before_action :set_user, only: %I[show edit update destroy followings followers]
>>>>>>> b720128b931a4830fb30f9570a6cc5b560fbf521

  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

<<<<<<< HEAD
  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
=======
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
>>>>>>> b720128b931a4830fb30f9570a6cc5b560fbf521
  end
end
