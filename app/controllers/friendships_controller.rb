class FriendshipsController < ApplicationController
  # フォローするとき
  def create
    user = User.find(params[:following_id])
    current_user.follow(params[:following_id])
    redirect_to user_path(user)
  end

  # フォロー外すとき
  def destroy
    Friendship.find_by(follower_id: current_user.id, following_id: params[:id]).destroy
    redirect_to user_path
  end
end
