class Politician < ActiveRecord::Base
  belongs_to :party
  belongs_to :constituency
  attr_accessible :name, :incumbent, :website, :incumbent_website, :facebook, :twitter, :youtube, :office_address, :phone_number, :email, :image, :image_file_name, :constituency_id, :party_id
  has_attached_file :image, :styles => { :medium => "300x300>", :small => "200x200>", :thumb => "100x100>" },
                    :url  => "/uploads/politician_image/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/uploads/politician_image/:id/:style/:basename.:extension"
end
