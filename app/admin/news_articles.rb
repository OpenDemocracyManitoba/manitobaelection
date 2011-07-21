ActiveAdmin.register NewsArticle do
  index do
    column :id
    column 'Title', :sortable => :title do |article|
      (link_to article.title, admin_news_article_path(article)).html_safe + " " +
      (link_to 'edit', edit_admin_news_article_path(article)).html_safe
    end
    column :source
    column :pubdate
    column 'URL' do |article|
      link_to 'link', article.url  unless article.url.blank?
    end
    column :moderation
    column 'Mentions' do |article|
      article.mentions.size.to_s
    end
    column :created_at
  end

end
