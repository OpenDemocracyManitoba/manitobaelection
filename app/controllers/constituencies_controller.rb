class ConstituenciesController < ApplicationController
  def index
    @constituencies = Constituency.all
  end

  def show
    @constituency = Constituency.find(params[:id])
  end
end
