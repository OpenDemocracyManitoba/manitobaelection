class Mention < ActiveRecord::Base
  GOOGLE_NEWS_URL_1 = 'http://news.google.ca/news?pz=1&cf=all&ned=ca&hl=en&as_maxm=3&q='
  GOOGLE_NEWS_URL_2 = '&as_qdr=a&as_drrb=q&as_mind=25&as_minm=2&cf=all&as_maxd=27&scoring=r&output=rss&num=50'
  # See bottom of file for query param help.

  belongs_to :politician
  belongs_to :news_article

  attr_accessible :summary, :politician, :news_article, :politician_id, :news_article_id

  # Scopes and Class Methods

  def self.by_politician(politician)
    where(:politician_id => politician.id)
  end

  def self.with_approved_news
    includes(:news_article).where('news_articles.moderation' => 'approved').order('news_articles.pubdate DESC')
  end

  def self.gnews_search_for(name)
    
    query = URI.escape('"' + name + '"' + ' location:manitoba')
    find_url = GOOGLE_NEWS_URL_1 + query + GOOGLE_NEWS_URL_2
    cfeed_raw = FeedNormalizer::FeedNormalizer.parse open(find_url)
    feed = []
    
    cfeed_raw.entries.each do |entry_raw|
      entry = {}
      title_elements = entry_raw.title.split('-')
      entry[:source] = title_elements.pop
      entry[:title] = (title_elements).join
      entry[:pubdate] = entry_raw.date_published
      description = Nokogiri::HTML::fragment(entry_raw.description)
      summary = description.xpath('.//font[@size=-1]')
      entry[:summary] = summary[1].inner_html
      entry[:gnews_url] = entry_raw.urls[0]
      entry[:url] = entry_raw.urls[0].split('url=')[1]
      feed << entry if entry[:summary].include? name
    end
    
    feed
    
  end
end

#Google News GET Parameters
#
#pz=1 - Unknown
#
#cf=all - Retrieve all content (deprecated) Was in the url twice?
#
#ned=ca - restrict to canadian edition
#
#hl=en - language is english
#
#q= - the actual search query. We append 'location:manitoba' to all queries.
#
#as_drrb=q - Retrieves articles added at...
#
#  as_qdr=a - ...any time.
#
#// Do we need these? Should only be used with as_drrb=b?
#as_maxm=3 - Only the last three months (1 - 12)
#as_mind=25 
#as_minm=2
#as_maxd=27
#
#scoring=r - sorts search results. Default: "r". Alias: "as_scoring"
#  "r" by relevance 
#  "n" by date (newest first) (We use to use n. It stopped working.)
#  "d" by date (newest first) with duplicates
#  "o" by date (oldest first)
#
#output=rss - atom also possible
#
#num=50 - Number of results 1 to 100.