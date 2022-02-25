class Publisher < User
  has_many :content_publishers,
            foreign_key: :user_id,
            dependent: :destroy
  has_many :contents, through: :content_publishers
end
