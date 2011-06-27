class Politician < ActiveRecord::Base
  belongs_to :party
  belongs_to :constituency
  attr_accessible :name, :incumbent, :website, :incumbent_website, :facebook, :twitter, :youtube, :office_address, :phone_number, :email, :image_file_name, :image_content_type, :image_file_size, :image_updated_at, :constituency_id
end
