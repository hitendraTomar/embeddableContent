FactoryBot.define do
  factory :content_stylesheet do
    name {Faker::Name.name}
    body {Faker::Lorem.sentences}
    association :embeddable_content, factory: :embeddable_content
    association :user, factory: :user
  end

end