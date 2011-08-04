class NewsArticle < ActiveRecord::Base
  MODERATION_OPTIONS = ['new', 'approved', 'rejected']
    
  attr_accessible :title, :source, :pubdate, :gnews_url, :url, :moderation, :rejection, :politician_ids

  validates_inclusion_of :moderation, :in => MODERATION_OPTIONS

  has_many :mentions, :dependent => :destroy
  has_many :politicians, :through => :mentions

  #Scopes and Class Methods
  
  default_scope order('pubdate DESC')

  def self.with_mentions_and_politicians
    includes(:mentions => :politician)
  end

  def self.with_politicians(politicians)
    includes(:mentions => :politician).where('politicians.id' => politicians)
  end

  def self.unmoderated
    where(:moderation => 'new')
  end

  def self.approved
    where(:moderation => 'approved')
  end

  def self.rejected
    where(:moderation => 'rejected')
  end
  

  # Virtual Attributes

  def pretty_date
    self.pubdate.blank? ? '' : self.pubdate.strftime("%A, %d %B %Y") 
  end
  
  def fixed_url
    URI.unescape(self.url)
  end
  
  before_update do |record|
    if record.moderation == 'rejected' && record.mentions.size > 0
      record.rejection ||= ''
      record.rejection += "\n<br/>\nPre-Rejection Mentions: " + record.mentions.inject(""){|str,m| str += "#{m.politician.name}, "}
      record.mentions.each { |m| m.delete }
    end
  end
end
