class AddDescriptionToConstituencies < ActiveRecord::Migration
  def self.up
    add_column :constituencies, :description, :text
  end

  def self.down
    remove_column :constituencies, :description
  end
end
