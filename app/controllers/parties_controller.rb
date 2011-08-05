class PartiesController < ApplicationController
  def index
    @parties = Party.all
  end

  def show
    @party = Party.includes(:politicians).find(params[:id])
    @latest_news_by_date = NewsArticle.approved.with_politicians(@party.politicians).limit(25).group_by(&:pretty_date)
  end
end
