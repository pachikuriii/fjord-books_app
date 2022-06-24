# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

<<<<<<< HEAD
  has_many :active_friendships,
=======
  has_many :followers,
>>>>>>> b720128b931a4830fb30f9570a6cc5b560fbf521
           class_name: 'Friendship',
           foreign_key: 'follower_id',
           dependent: :destroy,
           inverse_of: :follower
<<<<<<< HEAD

  has_many :passive_friendships,
           class_name: 'Friendship',
           foreign_key: 'followed_id',
           dependent: :destroy,
           inverse_of: :followed

  has_many :followings,
           through: :active_friendships,
           source: :followed

  has_many :followers,
           through: :passive_friendships,
           source: :follower

  def follow(other_user)
    active_friendships.create(followed_id: other_user)
  end

  def unfollow(other_user)
    active_friendships.find_by(followed_id: other_user).destroy
  end

  def following?(other_user)
    followings.include?(other_user)
=======
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
>>>>>>> b720128b931a4830fb30f9570a6cc5b560fbf521
  end
end
