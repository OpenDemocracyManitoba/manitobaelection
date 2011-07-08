class Constituency < ActiveRecord::Base
  has_many :politicians
  attr_accessible :name, :image, :image_file_name

  validates_presence_of :name
  validates_format_of :pdf_map_url, :with => /^(#{URI::regexp(%w(http https))})$/, :allow_blank => true

  has_attached_file :image, :styles => { :large => "500x500>", :medium => "300x300>", :small => "200x200>", :thumb => "100x100>" },
                    :url  => "/uploads/constituency_image/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/uploads/constituency_image/:id/:style/:basename.:extension"
end
