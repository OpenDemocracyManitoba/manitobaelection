class ConstituenciesController < ApplicationController
  def index
    @constituencies = Constituency.all
  end

  def show
    @constituency = Constituency.find(params[:id])
  end

  def new
    @constituency = Constituency.new
  end

  def create
    @constituency = Constituency.new(params[:constituency])
    if @constituency.save
      redirect_to @constituency, :notice => "Successfully created constituency."
    else
      render :action => 'new'
    end
  end

  def edit
    @constituency = Constituency.find(params[:id])
  end

  def update
    @constituency = Constituency.find(params[:id])
    if @constituency.update_attributes(params[:constituency])
      redirect_to @constituency, :notice  => "Successfully updated constituency."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @constituency = Constituency.find(params[:id])
    @constituency.destroy
    redirect_to constituencies_url, :notice => "Successfully destroyed constituency."
  end
end
