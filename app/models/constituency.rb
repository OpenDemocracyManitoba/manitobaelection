class Constituency < ActiveRecord::Base
  has_many :politicians
  attr_accessible :name, :image, :image_file_name
  has_attached_file :image, :styles => { :medium => "300x300>", :small => "200x200>", :thumb => "100x100>" },
                    :url  => "/uploads/constituency_image/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/uploads/constituency_image/:id/:style/:basename.:extension"
end
