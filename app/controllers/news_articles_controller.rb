class NewsArticlesController < ApplicationController
  def show
    @news_article = NewsArticle.find(params[:id])
  end

  def index
    @news_articles = NewsArticle.all
  end
end
