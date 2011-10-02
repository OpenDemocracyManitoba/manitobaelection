class PartiesController < ApplicationController
  
  caches_page :index, :show
  
  def index
    @parties = Party.all
  end

  def show
    @party = Party.with_politicians_and_constit.order('constituencies.name').find(params[:id])
    @latest_news_by_date = NewsArticle.approved.with_politicians(@party.politicians).limit(20).group_by(&:pretty_date)
    @leader = Politician.where(:party_id => @party, :party_leader => true).first
  end
end
