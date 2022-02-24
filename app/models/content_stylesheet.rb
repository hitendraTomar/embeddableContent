class ContentStylesheet < ApplicationRecord
  belongs_to :embeddable_contents
  belongs_to :user

  scope :by_user, ->(user_id) { where(user_id: user_id) }
end
