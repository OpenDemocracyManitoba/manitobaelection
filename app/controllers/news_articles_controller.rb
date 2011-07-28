class NewsArticlesController < ApplicationController 
  before_filter :authenticate_admin_user!, :only => [:update, :moderate]

  respond_to :js, :only => :update

  def show
    @news_article = NewsArticle.find(params[:id])
  end

  def index
    @news_articles = NewsArticle.all
  end

  def update
    @news_article = NewsArticle.find(params[:id])
    if !@news_article.update_attributes(params[:news_article])
      flash[:error] = "Could not update news article."
      redirect_to :action => :moderate
    else
      @unmoderated_count = NewsArticle.unmoderated.size
      @approved_count = NewsArticle.approved.size
      @rejected_count = NewsArticle.rejected.size
    end
  end

  def moderate
    @new_articles = NewsArticle.unmoderated.with_mentions_and_politicians
    @approved_articles = NewsArticle.approved.with_mentions_and_politicians
    @rejected_articles = NewsArticle.rejected.with_mentions_and_politicians
  end
end