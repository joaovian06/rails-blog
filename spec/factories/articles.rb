FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    text { Faker::Lorem.paragraph }
    category { :news }
  end
end
