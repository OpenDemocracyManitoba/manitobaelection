class Mention < ActiveRecord::Base
  belongs_to :politician
  belongs_to :news_article

  attr_accessible :summary

def self.gnews_search_for(name)
    
    query = URI.escape('"' + name +'"' + ' location:manitoba')
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
