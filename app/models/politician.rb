class Politician < ActiveRecord::Base

  belongs_to :party
  belongs_to :constituency

  has_many :mentions, :dependent => :destroy
  has_many :news_articles, :through => :mentions, :conditions =>'news_articles.moderation = "approved"'
  

  attr_accessible :name, :incumbent_since, :website, :incumbent_website, :facebook, :twitter, :youtube, :office_address, :phone_number, :email, :image, :image_file_name, :constituency_id, :party_id, :party_leader, :questionnaire

  validates_presence_of :name, :constituency, :party
  validates_format_of :website, :incumbent_website, :facebook, :youtube, :twitter, :with => /^(#{URI::regexp(%w(http https))})$/, :allow_blank => true
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_blank => true

  has_attached_file :image, :styles => { :medium => "300x300>", :small => "200x200>", :thumb => "100x100>" },
                    :url  => "/uploads/politician_image/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/uploads/politician_image/:id/:style/:basename.:extension"

  # Scopes and Class Methods
 
  scope :with_constituency, includes(:constituency)
  scope :with_party, includes(:party)
  scope :with_mentions, includes(:mentions)
  scope :incumbents, where(:incumbent => true)

  def self.by_name(name)
    where(:name => name).first
  end

  # Instance Methods

  def slug
    name.parameterize
  end

  def friendly_path
    Rails.application.routes.url_helpers.candidate_path(:id => self.id, :slug => self.slug)
  end

  #def googl_url
    #sleep(0.1)
    #client = Googl.client('username', 'password')
    #client.shorten('http://manitobaelection.ca'+friendly_path).short_url
  #end

  def first_name
    self.name.split[0]
  end

  # Virtual Attributes

  def incumbent_since=(year)
    if year.to_i > 0 || year.blank?
      self.incumbency_year = year
      self.incumbent = !incumbency_year.blank?
    end
  end

  def incumbent_since
    self.incumbency_year
  end



end
