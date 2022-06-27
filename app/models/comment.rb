class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :report
  belongs_to :commentable, polymorphic: true
end
