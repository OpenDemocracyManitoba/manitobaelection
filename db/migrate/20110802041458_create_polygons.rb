class CreatePolygons < ActiveRecord::Migration
  def self.up
    create_table :polygons do |t|
      t.integer :constituency_id
      t.integer :map_id
      t.text :coordinates
      t.string :link_type

      t.timestamps
    end
  end

  def self.down
    drop_table :polygons
  end
end
