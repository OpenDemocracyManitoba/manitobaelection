ActiveAdmin.register Mention do
  index do
    column :id
    column 'Summary' do |mention|
      truncate(mention.summary)
    end
    column :politician
    column 'News Article' do |mention|
      mention.news_article.title + ' ' + mention.news_article.id.to_s
    end
    column :created_at
    default_actions
  end
  
end
