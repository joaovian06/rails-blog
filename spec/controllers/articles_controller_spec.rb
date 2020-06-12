require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe '#index' do
    context 'no category selected' do
      let!(:articles) { FactoryBot.create_list(:article, 2) }

      before { get :index }

      it 'return all articles in view' do
        expect(assigns[:articles]).to match_array(articles)
      end

      it 'be organized in descending order' do
        expect(assigns[:articles]).to eq()
      end

      it 'be organized in pages' do

      end

      it 'should have a delimited number of article per page' do

      end
    end

    context 'category selected' do
      let!(:scientific) { FactoryBot.create(:article, category: :scientific) }
      let!(:news) { FactoryBot.create(:article, category: :news) }

      before { get :index, params: { category: :scientific } }

      it 'returns all articles of this category' do
        expect(assigns[:articles]).to eq [scientific]
      end
    end
  end

  describe '#show' do
    context 'given an article id' do
      it 'show a detail view of this article' do

      end
    end
  end

  decribe '#new' do
    context 'click in the "new" link' do
      it 'open the "new" form' do

      end
    end
  end

  describe '#edit' do
    context 'given an article id' do
      it 'must be able to edit articles attributes' do

      end
    end
  end

  describe '#create' do
    context 'given articles parameters' do
      it 'saves on db the new article and redirect to "show" view' do

      end
    end

    context 'missing articles parameters' do
      it 'render "new" view' do

      end
    end
  end

  describe '#update' do
    context 'given articles parameters' do
      it 'should update articles attributes' do

      end
    end

    context 'missing articles parameters' do
      it 'should render "edit" view' do

      end
    end
  end

  describe '#destroy' do
    context 'given an article id' do
      it 'should delete the article' do

      end

      it 'redirects to #index' do

      end

      it 'shows confirmation to delete' do

      end
    end
  end
end
