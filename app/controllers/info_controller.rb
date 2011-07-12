class InfoController < ApplicationController
  def index
    @days_until_election = Date.parse("2011 October 4") - Date.today
    @regions = Constituency::REGIONS
  end

  def regions
    @constituencies_by_region = Constituency.all_by_region
    @regions = Constituency::REGIONS
  end
end
