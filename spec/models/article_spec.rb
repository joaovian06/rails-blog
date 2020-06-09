require 'rails_helper'
RSpec.describe Article, type: :model do
  describe 'enums' do
    let(:article) { FactoryBot.create(:article) }
    it 'title must be present in a article' do
      #expect(article.title).not_to eq nil
      is_expected.to validate_presence_of(:title)
    end
    it 'title needs to have 5 caracters in less' do
      expect(article.title.length).to be >= 5
    end
    it 'article must have one category inside of this array' do
      is_expected.to define_enum_for(:category).with_values([:scientific, :entertainment, :news])
    end
  end
end
