FactoryBot.define do
  factory :comment do
    commenter { Faker::Name.name }
    comment { Faker::Lorem.paragraph }
  end
end
