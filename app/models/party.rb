class Party < ActiveRecord::Base
  has_many :politicians
  attr_accessible :name, :hex_colour, :website, :image, :image_file_name, :long_name, :email, :phone_number, :address, :facebook, :twitter, :youtube

  validates_presence_of :name

  has_attached_file :image, :styles => { :large => "500x500>", :medium => "300x300>", :small => "200x200>", :thumb => "100x100>" },
                    :url  => "/uploads/party_image/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/uploads/party_image/:id/:style/:basename.:extension"

  # Instance Methods

  def slug
    name.parameterize
  end

  def friendly_path
    Rails.application.routes.url_helpers.party_path(:id => self.id, :slug => self.slug)
  end
end
