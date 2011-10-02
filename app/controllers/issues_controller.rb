class IssuesController < ApplicationController
  
  caches_page :index
  
  def index
    @issues = Issue.all
  end
end
