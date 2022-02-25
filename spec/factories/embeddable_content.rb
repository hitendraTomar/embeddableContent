FactoryBot.define do
  factory :embeddable_content do
    title {Faker::Name.first_name}
    body {Faker::Internet.email}
    header {Faker::Name.first_name}
    footer {Faker::Internet.email}
    association :creator, factory: :creator
  end

end