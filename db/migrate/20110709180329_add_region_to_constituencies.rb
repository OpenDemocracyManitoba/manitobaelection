class AddRegionToConstituencies < ActiveRecord::Migration
  def self.up
    add_column :constituencies, :region, :string
  end

  def self.down
    remove_column :constituencies, :region
  end
end
