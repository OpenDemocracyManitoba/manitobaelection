class NewsArticle < ActiveRecord::Base
  MODERATION_OPTIONS = ['new', 'approved', 'rejected']
    
  validates_inclusion_of :moderation, :in => MODERATION_OPTIONS

  has_many :mentions, :dependent => :destroy
  has_many :politicians, :through => :mentions

  attr_accessible :title, :source, :pubdate, :gnews_url, :url, :moderation, :rejection, :politician_ids

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
