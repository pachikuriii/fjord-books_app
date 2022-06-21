# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :followers,
           class_name: 'Friendship',
           foreign_key: 'follower_id',
           dependent: :destroy,
           inverse_of: :follower
  has_many :followings,
           class_name: 'Friendship',
           foreign_key: 'following_id',
           dependent: :destroy,
           inverse_of: :follower

  has_many :following_users, through: :followers, source: :following
  has_many :follower_users, through: :followings, source: :follower

  # ユーザーをフォローする
  def follow(user_id)
    followers.create(following_id: user_id)
  end

  # ユーザーをフォロー解除する
  def unfollow(user_id)
    followers.find_by(following_id: user_id).destroy
  end

  # フォローしているかを判定
  def following?(user)
    following_users.include?(user)
  end
end
