class ArticlesController < ApplicationController
  http_basic_authenticate_with name: 'dhh', password: 'secret',
  except: [:index, :show]
  PER_PAGE = 10

  def index
    @articles = Article.order(created_at: :desc).page(param_page).per(PER_PAGE)
    @articles = @articles.where(category: filter_param) if filter_param.present?
    @articles = @articles.where('title LIKE ?', "%#{search_param}%") if search_param.present?
  end

  def show
    @article = Article.find_by(id: params[:id])
    redirect_to articles_path unless @article.present?
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find_by(id: params[:id])
    redirect_to articles_path unless @article.present?
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find_by(id: params[:id])
    @article.destroy if @article.present?

    redirect_to articles_path
  end

  private

  def search_param
    params[:search]
  end

  def filter_param
    params.fetch(:category, '')
  end

  def param_page
    params[:page] || 1
  end

  def article_params
    params.require(:article).permit(:title, :text, :category)
  end
end
