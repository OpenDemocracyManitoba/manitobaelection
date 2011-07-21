ActiveAdmin.register NewsArticle do
  index do
    column :id
    column 'Title', :sortable => :title do |article|
      link_to article.title, edit_admin_news_article_path(article)
    end
    column :source
    column :pubdate
    column 'URL' do |article|
      link_to 'link', article.fixed_url  unless article.url.blank?
    end
    column :moderation
    column 'Mentions' do |article|
      article.mentions.size.to_s
    end
    column :created_at
  end

  show do
    h3 news_article.title
    div do
      (
      link_to(news_article.source, news_article.url)  + 
      ' - ' + news_article.pretty_date).html_safe
    end
    br
    h4 'Mentions'
    div do
      news_article.mentions.inject("") do |str, mention|
        str += '<h5>' + mention.politician.name + '</h5>'
        str += (mention.summary.nil?) ? '<p>Summary Missing</p>' : '<p>' + mention.summary + '</p>'
      end.html_safe
    end
        
  end

  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :source
      f.input :pubdate
      f.input :url
    end

    f.inputs "Moderation and Mentioned Candidates" do
      f.input :moderation, :collection => NewsArticle::MODERATION_OPTIONS
      f.input :rejection
      f.input :politicians, :as => :check_boxes
    end

    f.buttons
  end

end
