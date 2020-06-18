require 'rails_helper'
require 'date'

RSpec.describe ArticlesController, type: :controller do
  describe '#index' do
    describe 'categories' do
      context 'no category selected' do
        let!(:articles) { FactoryBot.create_list(:article, 2) }
        before { get :index }

        it 'return all articles in view' do
          expect(assigns[:articles]).to match_array(articles)
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

    context 'paginate' do
      let!(:articles) { FactoryBot.create_list(:article, 11) }
      before do
        get :index
      end

      it 'should have a delimited number of articles per page' do
        expect(Kaminari.paginate_array(articles).page(2).per(10).length).to eq(1)
      end
    end

    context 'ordenate' do
      let!(:article1) { FactoryBot.create(:article, created_at: DateTime.new(2020, 6, 17, 10, 23, 19)) }
      let!(:article2) { FactoryBot.create(:article, created_at: DateTime.new(2020, 6, 16, 10, 23, 19)) }
      let!(:article3) { FactoryBot.create(:article, created_at: DateTime.new(2020, 6, 22, 10, 23, 19)) }

      before do
        get :index
      end

      it 'be organized in descending order' do
        expect(assigns[:articles]).to eq([article3, article1, article2])
      end
    end
  end

  describe '#show' do
    let(:article) { FactoryBot.create(:article) }
    context 'when article_id is present and valid' do
      before { get :show, params: { id: article.id } }

      it 'render show page' do
        is_expected.to render_template :show
      end
    end

    context 'when articles_id is not valid' do
      before { get :show, params: { id: 'hh' } }

      it 'redirect to index' do
        expect(response).to redirect_to(articles_path)
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

    context 'when article_id is valid' do
      let(:article) { FactoryBot.create(:article) }
      before do
        user = 'dhh'
        pw = 'secret'
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, pw)
        get :edit, params: { id: 'hh' }
      end

      it 'redirects to #index' do
        expect(response).to redirect_to(articles_path)
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
        patch :update, params: { id: article.id, article: { text: 'anything' } }
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
    let!(:article) { FactoryBot.create(:article) }
    context 'when article_id is present and valid' do
      before do
        user = 'dhh'
        pw = 'secret'
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, pw)
      end

      it 'redirects to index page' do
        delete :destroy, params: { id: article.id }
        expect(response).to redirect_to(articles_path)
      end

      it 'destroy the article' do
        expect { delete :destroy, params: { id: article.id } }.to change(Article, :count).by(-1)
      end
    end

    context 'when article_id is not valid' do
      before do
        user = 'dhh'
        pw = 'secret'
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, pw)
        delete :destroy, params: { id: 'hh' }
      end
      it 'redirects to index page' do
        expect(response).to redirect_to(articles_path)
      end

      it 'does not destroy the article' do
        expect { delete :destroy, params: { id: 'hh' } }.to_not change(Article, :count)
      end
    end
  end
end
