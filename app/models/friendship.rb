<<<<<<< HEAD
# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  validates :follower_id, presence: true
  validates :followed_id, presence: true
=======
class Friendship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'User'
  validates :follower_id, presence: true
  validates :following_id, presence: true
>>>>>>> b720128b931a4830fb30f9570a6cc5b560fbf521
end
