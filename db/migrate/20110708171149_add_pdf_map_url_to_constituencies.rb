class AddPdfMapUrlToConstituencies < ActiveRecord::Migration
  def self.up
    add_column :constituencies, :pdf_map_url, :string
  end

  def self.down
    remove_column :constituencies, :pdf_map_url
  end
end
