class Comment < ApplicationRecord
  belongs_to :postable, polymorphic: true
end
