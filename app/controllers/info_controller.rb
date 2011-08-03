class InfoController < ApplicationController
  def index
    @days_until_election = Date.parse("2011 October 4") - Date.today
    @regions = Constituency::REGIONS
    latest_news = NewsArticle.approved.with_mentions_and_politicians.limit(6)
    @latest_news_by_date = latest_news.group_by(&:pretty_date)
  end

  def regions
    @constituencies_by_region = Constituency.all_by_region
    @regions = Constituency::REGIONS
  end
end
