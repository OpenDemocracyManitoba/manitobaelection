class CreateParties < ActiveRecord::Migration
  def self.up
    create_table :parties do |t|
      t.string :name
      t.string :hex_colour
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.string :website
      t.timestamps
    end
  end

  def self.down
    drop_table :parties
  end
end
