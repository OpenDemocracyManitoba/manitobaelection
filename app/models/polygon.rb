class Polygon < ActiveRecord::Base
  POLYGON_TYPES = ['constituency', 'submap']

  belongs_to :map
  belongs_to :constituency
  belongs_to :submap, :class_name => 'Map'

  attr_accessible :constituency_id, :map_id, :coordinates, :link_type, :submap_id

  validates_inclusion_of :link_type, :in => POLYGON_TYPES
  validates_presence_of :map_id, :link_type
  validate :must_link_to_constituency_or_submap

  def must_link_to_constituency_or_submap
    errors.add(:link_type, "Must link to a constituency or a submap")  if (link_type == 'constituency' && constituency_id.nil?) || (link_type == 'submap' && submap_id.nil?)
  end

  before_save :nil_other_link_type_id

  private

  def nil_other_link_type_id
    if self.link_type == 'constituency'
      self.submap_id = nil
    else
      self.constituency_id = nil
    end
  end

end
