class PoliticiansController < ApplicationController
  def index
    @constituencies_by_region = Constituency.with_politicians.all_by_region
    @regions = Constituency::REGIONS
  end

  def show
    @politician = Politician.with_party.find(params[:id])
    @mentions = Mention.with_approved_news.by_politician(@politician).page(params[:page]).per(10)
  end

  def incumbents
    @politicians = Politician.incumbents.with_party.with_constituency.order('constituencies.name')
  end
end
