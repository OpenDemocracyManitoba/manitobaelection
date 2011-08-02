class AddSubmapIdToPolygons < ActiveRecord::Migration
  def self.up
    add_column :polygons, :submap_id, :integer
  end

  def self.down
    remove_column :polygons, :submap_id
  end
end
