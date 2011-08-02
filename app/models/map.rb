class Map < ActiveRecord::Base
  has_many :polygons, :dependent => :destroy

  accepts_nested_attributes_for :polygons, :reject_if => lambda { |p| p[:link_type].blank? }, :allow_destroy => true
  attr_accessible :name, :description, :image, :image_file_name, :polygons_attributes

  has_attached_file :image, :styles => { :three_column => "918x2000>", :two_column => "598x1200>", :medium => "400x400>", :small => "200x200>", :thumb => "100x100>" },
                    :url  => "/uploads/map_image/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/uploads/map_image/:id/:style/:basename.:extension"

  validates_presence_of :name


end
