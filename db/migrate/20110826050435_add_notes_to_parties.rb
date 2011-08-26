class AddNotesToParties < ActiveRecord::Migration
  def self.up
    add_column :parties, :notes, :text
  end

  def self.down
    remove_column :parties, :notes
  end
end
