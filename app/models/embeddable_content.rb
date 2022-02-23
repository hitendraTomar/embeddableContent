class EmbeddableContent < ApplicationRecord
  has_many :content_publishers, dependent: :destroy
  has_many :publishers, through: :content_publishers
  has_many :content_stylesheets, dependent: :destroy
  belongs_to :creator, class_name: :User, foreign_key: :user_id
end
