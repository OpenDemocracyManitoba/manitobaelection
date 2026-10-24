namespace :cache do
  task reseed: [:clear, :seed]  do
  end

  desc "DANGER: Remove existing HTML cached to public folder."
  task :clear do
    puts 'Flushing existing public folder HTML cache'
    puts sh('touch /var/www/manitobaelection.ca/production/tmp/restart.txt')
    puts sh('rm -f /var/www/manitobaelection.ca/production/public/candidates.html')
    puts sh('rm -f /var/www/manitobaelection.ca/production/public/constituencies.html')
    puts sh('rm -f /var/www/manitobaelection.ca/production/public/election-2011.html')
    puts sh('rm -f /var/www/manitobaelection.ca/production/public/historic-maps.html')
    puts sh('rm -f /var/www/manitobaelection.ca/production/public/by-election-2012.html')
    puts sh('rm -f /var/www/manitobaelection.ca/production/public/index.html')
    puts sh('rm -f /var/www/manitobaelection.ca/production/public/issues.html')
    puts sh('rm -f /var/www/manitobaelection.ca/production/public/news_articles.html')
    puts sh('rm -f /var/www/manitobaelection.ca/production/public/parties.html')
    puts sh('rm -f /var/www/manitobaelection.ca/production/public/search.html')
    puts sh('rm -rf /var/www/manitobaelection.ca/production/public/candidates')
    puts sh('rm -rf /var/www/manitobaelection.ca/production/public/constituencies')
    puts sh('rm -rf /var/www/manitobaelection.ca/production/public/maps')
    puts sh('rm -rf /var/www/manitobaelection.ca/production/public/news_articles')
    puts sh('rm -rf /var/www/manitobaelection.ca/production/public/pages')
    puts sh('rm -rf /var/www/manitobaelection.ca/production/public/parties')
  end

  desc "Visit all pages we which to seed to the public folder file cache."
  task :seed => :environment do
    require 'open-uri'
    BASE_URL = 'http://2011.manitobaelection.ca'

    def visit_route(current_route)
      retries ||= 2
      to_visit = BASE_URL + current_route
      print to_visit
      io = open(to_visit)
      puts io.status.inspect
      #io.each_line {|line| puts line}

      print " ! Coule not open #{to_visit}" unless io.status.first == '200'
      puts
    rescue OpenURI::HTTPError => error
        puts "## Retrying... ##"
        retry unless (retries -= 1).zero?
    end

    def visit_pagination(current_route, scope, per_page = 25)
      page_count = ((scope.count - 1) / per_page).to_i + 1
      (2..page_count).each { |i| visit_route("#{current_route}/page/#{i}") }
    end

    # / - Home Page
    visit_route('/')

    # /pages/:id/:slug - Many: All CMS Pages
    Page.all.each do |page|
      visit_route(page.friendly_path)
    end

    # /issues - One page
    visit_route('/issues')

    # /news_articles(/page/:page) - Paginated News Articles
    visit_route('/news_articles')
    visit_pagination('/news_articles',NewsArticle.approved)

    # /maps/:id/:slug - All maps
    Map.all.each do |map|
      visit_route(map.friendly_path)
    end

    # /constituencies # One page
    visit_route(/'constituencies')

    # /constituencies/:id/:slug # One per page
    Constituency.all.each do |constituency|
      visit_route(constituency.friendly_path)
    end

    # /candidates # All candidates one page.
    visit_route('/candidates')

    # /candidates/incumbents # All candidates one page.
    visit_route('/candidates/incumbents')

    # /candidates/:id/:slug(/page:page) # One per candidate, paginated.
    Politician.all.each do |candidate|
      visit_route(candidate.friendly_path)
      visit_pagination(candidate.friendly_path, Mention.with_approved_news.by_politician(candidate), 10)
    end

    # /parties # One page, all parties
    visit_route('/parties')

    # /parties/:id/:slug # One page per party
    Party.all.each do |party|
      visit_route(party.friendly_path)
    end

    # Misc one off pages
    visit_route('/search')
    visit_route('/historic-maps')
    visit_route('/election-2011')
    visit_route('/by-election-2012')
  end
end
