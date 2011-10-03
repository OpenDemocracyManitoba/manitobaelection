class InfoController < ApplicationController
  
  caches_page :index, :historic, :search
  
  def index
    @days_until_election = Date.parse("2011 October 4") - Date.today
    latest_news = NewsArticle.approved.with_mentions_and_politicians.limit(6)
    @latest_news_by_date = latest_news.group_by(&:pretty_date)
    maps_hash = Map.all.group_by(&:name)
    # Force the maps into the same order as the REGIONS array.
    @maps = Constituency::REGIONS.map { |name| maps_hash[name][0] }
    @parties = Party.all
  end
  
  # view only
  def historic
  end
  
  #view only
  def search
  end

  def regions
    @constituencies_by_region = Constituency.all_by_region
    @regions = Constituency::REGIONS
  end
end
