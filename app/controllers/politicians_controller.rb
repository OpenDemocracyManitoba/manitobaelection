class PoliticiansController < ApplicationController
  def index
    @politicians = Politician.all
  end

  def show
    @politician = Politician.find(params[:id])
  end

  def new
    @politician = Politician.new
  end

  def create
    @politician = Politician.new(params[:politician])
    if @politician.save
      redirect_to @politician, :notice => "Successfully created politician."
    else
      render :action => 'new'
    end
  end

  def edit
    @politician = Politician.find(params[:id])
  end

  def update
    @politician = Politician.find(params[:id])
    if @politician.update_attributes(params[:politician])
      redirect_to @politician, :notice  => "Successfully updated politician."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @politician = Politician.find(params[:id])
    @politician.destroy
    redirect_to politicians_url, :notice => "Successfully destroyed politician."
  end
end
