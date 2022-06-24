<<<<<<< HEAD
# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    current_user.follow(params[:id])
    redirect_to user_path
  end

  def destroy
    current_user.unfollow(params[:id])
=======
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
>>>>>>> b720128b931a4830fb30f9570a6cc5b560fbf521
    redirect_to user_path
  end
end
