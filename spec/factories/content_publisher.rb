FactoryBot.define do
  factory :content_publisher do
    header {Faker::Lorem.sentences}
    footer {Faker::Lorem.sentences}
    association :publisher, factory: :publisher
    association :content, factory: :embeddable_content
  end

end