class Creator < User
  has_many :contents, class_name: :EmbeddableContent, dependent: :destroy
end
