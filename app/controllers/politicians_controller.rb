class PoliticiansController < ApplicationController
  def index
    @constituencies_by_region = Constituency.with_politicians.all_by_region
    @regions = Constituency::REGIONS
  end

  def show
    @politician = Politician.find(params[:id])
  end

  def incumbents
    @politicians = Politician.incumbents.with_party.with_constituency.order('constituencies.name')
  end
end
