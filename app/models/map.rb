class Map < ActiveRecord::Base
  has_many :polygons, :dependent => :destroy

  accepts_nested_attributes_for :polygons, :reject_if => lambda { |p| p[:link_type].blank? }, :allow_destroy => true
  attr_accessible :name, :description, :image, :image_file_name, :polygons_attributes

  has_attached_file :image, :styles => { :three_column => "918x2000>", :two_column => "598x1200>", :one_column => "278x600>", :medium => "200x400>", :small => "130x260>", :thumb => "100x200>" },
                    :url  => "/uploads/map_image/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/uploads/map_image/:id/:style/:basename.:extension"

  validates_presence_of :name
  validates_inclusion_of :name, :in => Constituency::REGIONS

  # Instance Methods

  def slug
    self.name.parameterize
  end

  def friendly_path
    Rails.application.routes.url_helpers.friendly_map_path(:id => self.id, :slug => self.slug)
  end

end
