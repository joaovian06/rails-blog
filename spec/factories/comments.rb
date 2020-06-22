FactoryBot.define do
  factory :comment do
    article
    commenter { Faker::Name.name }
    body { Faker::Lorem.paragraph }
  end
end
