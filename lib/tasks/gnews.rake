namespace :gnews do
  task :find_mentions => :environment do
    require 'open-uri'
    require 'pp'

    politicians = Politician.all
    
    for politician in politicians do
      articles = Mention.gnews_search_for(politician.name)

      puts "Looking for mentions of #{politician.name}."
      puts "  #{articles.size} Articles."

      mention_count = 0
      for article in articles do
        begin
          current_article = NewsArticle.find_or_create_by_url(article)
        rescue Exception
          puts "Unable to find or create: "
          pp article
        else
          if !current_article.politicians.include?(politician)
            mention_count += 1
            mention = Mention.new(:politician => politician, :news_article => current_article, :summary => article[:summary])
            puts "    Error saving mention for #{current_article.title}." if !mention.save
          end
          #if current_article.moderation == 'new'
            #current_article.moderation = 'approved'
            #current_article.save
          #end
        end
      end
      puts "  !! #{mention_count} New Mentions. !!" if mention_count != 0
    end
    puts
  end
end
