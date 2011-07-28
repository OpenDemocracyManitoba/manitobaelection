class NewsArticlesController < ApplicationController 
  before_filter :authenticate_admin_user!, :only => [:update, :moderate]

  def show
    @news_article = NewsArticle.find(params[:id])
  end

  def index
    @news_articles = NewsArticle.all
  end

  def update
   @news_article = NewsArticle.find(params[:id])
   if @news_article.update_attributes(params[:news_article])
     flash[:notice] = "News article updated."
   else
     flash[:error] = "Could not update news article."
    end
     redirect_to :action => :moderate
  end

  def moderate
    @new_articles = NewsArticle.order('pubdate DESC').includes(:mentions => :politician).where(:moderation => 'new').all
    @approved_articles = NewsArticle.order('pubdate DESC').includes(:mentions => :politician).where(:moderation => 'approved').all
    @rejected_articles = NewsArticle.order('pubdate DESC').includes(:mentions => :politician).where(:moderation => 'rejected').all
  end
end
