class EmbeddableContent < ApplicationRecord
  paginates_per 10

  has_many :content_publishers,
            dependent: :destroy
  has_many :publishers,
            through: :content_publishers
  has_many :content_stylesheets,
            dependent: :destroy
  belongs_to :creator,
              class_name: :User,
              foreign_key: :user_id

  accepts_nested_attributes_for :content_stylesheets,
    allow_destroy: true

  accepts_nested_attributes_for :content_publishers,
    allow_destroy: true

  validates_presence_of :title
end
