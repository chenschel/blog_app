class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :article, only: %i[edit update show destroy]
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = 'Article has been created'
      redirect_to articles_path
    else
      flash.now[:danger] = 'Article has not been created'
      render :new
    end
  end

  def edit
    if current_user != @article.user
      flash.now[:danger] = 'You can only edit your own articles'
      redirect_to root_path
    end
  end

  def update
    if current_user != @article.user
      flash.now[:danger] = 'You can only edit your own articles'
      redirect_to root_path
    else
      if @article.update(article_params)
        flash[:success] = 'Article has been updated'
        redirect_to @article
      else
        flash.now[:danger] = 'Article has not been updated'
        render :edit
      end
    end
  end

  def show
    @comment = @article.comments.build
  end

  def destroy
    return unless @article.destroy

    flash[:success] = 'Article has been deleted'
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def article
    @article = Article.find(params[:id])
  end
end
