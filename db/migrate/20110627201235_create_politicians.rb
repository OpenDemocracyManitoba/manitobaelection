class CreatePoliticians < ActiveRecord::Migration
  def self.up
    create_table :politicians do |t|
      t.string :name
      t.boolean :incumbent
      t.string :website
      t.string :incumbent_website
      t.string :facebook
      t.string :twitter
      t.string :youtube
      t.string :office_address
      t.string :phone_number
      t.string :email
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.integer :constituency_id
      t.timestamps
    end
  end

  def self.down
    drop_table :politicians
  end
end
