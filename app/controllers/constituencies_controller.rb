class ConstituenciesController < ApplicationController
  def index
    @constituencies_by_region = Constituency.all_by_region
    @regions = Constituency::REGIONS
  end

  def show
    @constituency = Constituency.with_politicians.find(params[:id])
    
    @latest_news_by_date = NewsArticle.approved.with_politicians(@constituency.politicians).limit(10).group_by(&:pretty_date)
  end
end
