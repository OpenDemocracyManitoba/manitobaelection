class AddManyIndexes < ActiveRecord::Migration
  def self.up
    add_index :news_articles, :pubdate
    add_index :news_articles, :url
    add_index :news_articles, :moderation
    add_index :mentions, :politician_id
    add_index :mentions, :news_article_id
    add_index :constituencies, :region
    add_index :politicians, :constituency_id
    add_index :politicians, :party_id
    add_index :politicians, :party_leader
    add_index :polygons, :map_id
    add_index :polygons, :submap_id
    add_index :polygons, :constituency_id
  end

  def self.down
    remove_index :news_articles, :pubdate
    remove_index :news_articles, :url
    remove_index :news_articles, :moderation
    remove_index :mentions, :politician_id
    remove_index :mentions, :news_article_id
    remove_index :constituencies, :region
    remove_index :politicians, :constituency_id
    remove_index :politicians, :party_id
    remove_index :politicians, :party_leader
    remove_index :polygons, :map_id
    remove_index :polygons, :submap_id
    remove_index :polygons, :constituency_id
  end
end
