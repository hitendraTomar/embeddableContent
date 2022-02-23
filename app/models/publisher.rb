class Publisher < User
  has_many :content_publishers, dependent: :destroy
  has_many :contents, through: :content_publishers
end
