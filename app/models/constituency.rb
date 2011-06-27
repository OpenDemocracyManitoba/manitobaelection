class Constituency < ActiveRecord::Base
  has_many :politicians
  attr_accessible :name, :image_file_name, :image_content_type, :image_file_size, :image_updated_at
end
