class MapsController < ApplicationController
  before_filter :authenticate_admin_user!, :except => :show
  
  caches_page :show

  def show
    @map = Map.find(params[:id])
    # Oh oh. This is a fakey foreign association here with maps. A map belongs to a region. As does a constit.
    @constituencies = Constituency.where(:region => @map.name)
  end

  def index
    @maps = Map.all
  end

  def edit
    @map = Map.find(params[:id])
    @map.polygons.build
  end

  def update
    @map = Map.find(params[:id])
    if @map.update_attributes(params[:map])
      redirect_to edit_map_path(@map), :notice => 'Successfully updated map.'
    else
      render :action => :edit
    end
  end

end
