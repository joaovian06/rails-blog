require '../app/models/article.rb'
RSpec.describe Article, type: :model do
  it do
    is_expected.to define_enum_for(:category).with_values([:scientific, :entertainment, :news])
  end
end
