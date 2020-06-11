require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { FactoryBot.create(:article) }

  describe 'enums' do
    it 'article must have one category inside of this array' do
      is_expected.to define_enum_for(:category).with_values([:scientific, :entertainment, :news])
    end
  end
  describe 'validations' do
    describe 'title' do
      it 'title must be present in a article' do
        is_expected.to validate_presence_of(:title)
      end
      it 'title needs to have 5 caracters in less' do
        expect(article.title.length).to be >= 5
      end
    end

    describe 'category' do
      it 'must be present in an article' do
        is_expected.to validate_presence_of(:category)
      end
    end

    describe 'text' do
      it 'must be presente in an article' do
        is_expected.to validate_presence_of(:text)
      end
    end
  end

  describe 'comment' do
    it 'article must have many comments' do
      is_expected.to have_many(:comments)
    end
  end
end
