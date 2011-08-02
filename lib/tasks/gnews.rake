namespace :gnews do
  task :find_mentions => :environment do
    require 'open-uri'

    Rails.logger.info "News Scrape START: #{Time.now}"

    politicians = Politician.all
    total_mentions = 0

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
             Rails.logger.error "News Error: #{current_article.title} DID NOT SAVE"
            end
          end
          #if current_article.moderation == 'new'
            #current_article.moderation = 'approved'
            #current_article.save
          #end
        end
        sleep rand # Currently paranoid...
      end
     # puts "  !! #{mention_count} New Mentions. !!" if mention_count != 0
    end
    # puts
    Rails.logger.info "Total New Mentions: #{total_mentions}"
    Rails.logger.info "News Scrape END: #{Time.now}"
  end
end
