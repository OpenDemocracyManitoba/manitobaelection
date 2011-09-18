class Constituency < ActiveRecord::Base
  
  REGIONS = ["Winnipeg", "Northern Manitoba", "Brandon", "Southern Manitoba"]
  has_many :politicians
  attr_accessible :name, :image, :image_file_name, :pdf_map_url, :region, :description

  validates_inclusion_of :region, :in => REGIONS
  validates_presence_of :name
  validates_format_of :pdf_map_url, :with => /^(#{URI::regexp(%w(http https))})$/, :allow_blank => true

  has_attached_file :image, :styles => { :large => "500x500>", :medium => "300x300>", :small => "200x200>", :thumb => "100x100>" },
                    :url  => "/uploads/constituency_image/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/uploads/constituency_image/:id/:style/:basename.:extension"

  # Scopes and Class Methods
  
  scope :with_politicians, includes(:politicians => :party)
  scope :with_mentions, includes(:politicians => :mentions)

  def self.all_by_region
    order(:name).group_by(&:region)
  end

  def self.with_approved_news
    includes(:politicians => {:mentions => :news_article})
  end


  # Instance Methods

  def slug
    self.name.parameterize
  end

  def friendly_path
    Rails.application.routes.url_helpers.constituency_path(:id => self.id, :slug => self.slug)
  end

end
