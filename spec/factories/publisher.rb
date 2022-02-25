FactoryBot.define do
  factory :publisher do
    name {Faker::Name.first_name}
    email {Faker::Internet.email}
    password {Faker::Internet.password}
  end

end