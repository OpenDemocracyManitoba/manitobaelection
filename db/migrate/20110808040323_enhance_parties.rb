class EnhanceParties < ActiveRecord::Migration
  def self.up
    add_column :parties, :facebook, :string  
    add_column :parties, :youtube, :string  
    add_column :parties, :twitter, :string  
    add_column :parties, :long_name, :string  
    add_column :parties, :email, :string  
    add_column :parties, :phone_number, :string  
    add_column :parties, :address, :string  
  end

  def self.down
    remove_column :parties, :facebook
    remove_column :parties, :youtube
    remove_column :parties, :twitter
    remove_column :parties, :long_name
    remove_column :parties, :email
    remove_column :parties, :phone_number
    remove_column :parties, :address
  end
end
