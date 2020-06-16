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
    context 'when article_id is present and valid' do
      let(:article) { FactoryBot.create(:article) }
      before { get :show, params: { id: article.id } }

      it 'render show page' do
        is_expected.to render_template :show
      end
    end

    context 'when article_id is not present' do
      it 'redirect to error page' do
      end
    end

    context 'when articles_id is not valid' do
      it 'redirect to error page' do
      end
    end
  end

  describe '#new' do
    context 'when http_autenticate is given' do
      before do
        user = 'dhh'
        pw = 'secret'
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, pw)
        get :new
      end

      it 'renders new page' do
        is_expected.to render_template :new
      end
    end

    context 'when http_autenticate not given' do
      before { get :new }
      it 'unauthorizate to create new article' do
        is_expected.to respond_with(401)
      end
    end
  end

  describe '#create' do
    context 'when articles params are valid' do
      let(:article) { FactoryBot.create(:article) }
      before do
        user = 'dhh'
        pw = 'secret'
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, pw)
        post :create, params: { article: { title: 'My Rose', text: 'flowers', category: 'news' } }
      end

      it 'redirect_to show page' do
        expect(response).to redirect_to(article_path(assigns[:article]))
      end
    end

    context 'when articles params is not valid' do
      before do
        user = 'dhh'
        pw = 'secret'
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, pw)
        post :create, params: { article: { title: '', text: '', category: '' } }
      end

      it 'renders new page' do
        is_expected.to render_template(:new)
      end
    end
  end

  describe '#edit' do
    context 'when article_id is present and valid' do
      let(:article) { FactoryBot.create(:article) }
      before do
        user = 'dhh'
        pw = 'secret'
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, pw)
        get :edit, params: { id: article.id }
      end

      it 'renders edit page' do
        expect(response).to render_template(:edit)
      end
    end

    context 'when article_id is not present' do
      it 'redirects to error page' do
      end
    end

    context 'when article_id is not valid' do
      it 'redirects to error page' do
      end
    end
  end

  describe '#update' do
    let(:article) { FactoryBot.create(:article) }
    context 'when articles params are valid' do
      before do
        user = 'dhh'
        pw = 'secret'
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, pw)
        patch :update, params: { id: article.id, article: { text: 'asoufhaof' } }
      end

      it 'redirects to show page' do
        expect(response).to redirect_to(article_path(assigns[:article]))
      end
    end

    context 'when articles params are not valid' do
      before do
        user = 'dhh'
        pw = 'secret'
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, pw)
        patch :update, params: { id: article.id, article: { text: '', title: '', category: '' } }
      end

      it 'renders edit page' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy' do
    context 'when article_id is present and valid' do
      it 'redirects to index page' do
      end

      it 'destroy the article' do
      end
    end

    context 'when article_id is not valid' do
      it 'redirects to index page' do
      end

      it 'does not destroy the article' do
      end
    end
  end
end
