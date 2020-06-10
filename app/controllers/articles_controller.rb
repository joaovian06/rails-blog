class ArticlesController < ApplicationController
  http_basic_authenticate_with name: 'dhh', password: 'secret',
  except: [:index, :show]
  PER_PAGE = 10
  def index
    if filter_param.empty?
      @articles = Article.order(created_at: :desc).page(param_page)
    else
      @articles = Article.order(created_at: :desc).page(param_page).where(category: filter_param)
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
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

    if @articles.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private

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
