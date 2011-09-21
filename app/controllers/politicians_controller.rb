class PoliticiansController < ApplicationController
  before_filter :authenticate_admin_user!, :only => [:twitter,:questionnaires,:tweets]
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

  def twitter
    @politicians = Politician.where('twitter IS NOT NULL AND twitter != ""')
  end

  def questionnaires
    @politician = Politician.all
    @senders = ['Mike','Kyle','Andrew']
  end

  def tweets
    @politician = Politician.with_party.with_constituency.where('questionnaire != ""').order('updated_at ASC')
  end

  def contacts
    @constituencies_by_region = Constituency.with_politicians.all_by_region
    @regions = Constituency::REGIONS
  end
end
