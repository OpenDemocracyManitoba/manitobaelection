class ConstituenciesController < ApplicationController
  def index
    @constituencies_by_region = Constituency.all_by_region
    @regions = Constituency::REGIONS
  end

  def show
    @constituency = Constituency.with_politicians.find(params[:id])
  end
end
