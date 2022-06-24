# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    current_user.follow(params[:id])
    redirect_to user_path
  end

  def destroy
    current_user.unfollow(params[:id])
    redirect_to user_path
  end
end
