class AddIncumbencyYearToPoliticians < ActiveRecord::Migration
  def self.up
    add_column :politicians, :incumbency_year, :integer
  end

  def self.down
    remove_column :politicians, :incumbency_year
  end
end
