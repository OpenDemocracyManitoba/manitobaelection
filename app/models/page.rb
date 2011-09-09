class Page < ActiveRecord::Base
  attr_accessible :title, :content, :permalink, :show_title

  validates_presence_of :permalink

  # Instance Methods

  def slug
    self.permalink.parameterize
  end

  def friendly_path
    Rails.application.routes.url_helpers.friendly_page_path(:id => self.id, :slug => self.slug)
  end

  def markup
    RDiscount.new(self.content, :smart).to_html
  end

  # Synonym for title.
  def name
    self.title
  end
end
