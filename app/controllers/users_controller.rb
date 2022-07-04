# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def followings
    user = User.includes(avatar_attachment: :blob).find(params[:id])
    @users = user.followings.with_attached_avatar
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers.with_attached_avatar
  end
end
