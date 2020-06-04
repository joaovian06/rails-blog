FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    text { Faker::Lorem.paragraph }
    category { [:scientific, :entertainment, :news].sample }
  end
end
