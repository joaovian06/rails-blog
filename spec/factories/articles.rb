FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    text { Faker::Lorem.paragraph }
    category { Article.categories.keys.sample }
  end
end
