class ContentPublisher < ApplicationRecord
  belongs_to :publisher, class_name: :User, foreign_key: :user_id
  belongs_to :content, class_name: :EmbeddableContent, foreign_key: :embeddable_content_id

  def user
    User.find_by_id(user_id)
  end
end
