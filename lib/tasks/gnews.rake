namespace :gnews do
  task :find_mentions => :environment do
    require 'open-uri'

    init_logger

    start = Time.now

    politicians = Politician.all
    total_mentions = 0
    auto_approved = 0

    for politician in politicians do
      articles = Mention.gnews_search_for(politician.name)

     # puts "Looking for mentions of #{politician.name}."
     # puts "  #{articles.size} Articles."

      mention_count = 0
      for article in articles do
        begin
          # Currently throwing a warning, since the summary is embedded in `article`.
          current_article = NewsArticle.find_or_create_by_url(article)
        rescue Exception
           Rails.logger.error "Unable to find or create article."
        else
          if !current_article.politicians.include?(politician)
            mention_count += 1
            total_mentions += 1
            mention = Mention.new(:politician => politician, :news_article => current_article, :summary => article[:summary])
            if !mention.save
             Rails.logger.error "News Error: Mention for #{current_article.title} DID NOT SAVE"
            end
          end
          # Auto approve articles that mention more than one candidate.
          # if current_article.moderation == 'new' && current_article.mentions.size > 1
          # Auto approve articles, unless they mention only mike brown.
          # if current_article.moderation == 'new' && (politician.name != 'Mike Brown' || current_article.mentions.size > 1) && politician.name != 'Darrell Ackman'
          #   current_article.moderation = 'approved'
          #   current_article.save
          #   auto_approved += 1
          # end
        end
      end
     # puts "  !! #{mention_count} New Mentions. !!" if mention_count != 0
    end
    # puts
    Rails.logger.info "Total New Mentions: #{total_mentions}"
    Rails.logger.info "Auto-Approved Articles: #{auto_approved}"
    Rails.logger.info "News Scrape Seconds: #{Time.now - start}"
  end

  def init_logger
    if defined?(Rails) 
      # if (Rails.env == 'development')
        Rails.logger = Logger.new(STDOUT)
      #else
      #  Rails.logger.auto_flushing = true
      #end
    end
  end
    
end
