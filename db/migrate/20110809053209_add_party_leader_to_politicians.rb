class AddPartyLeaderToPoliticians < ActiveRecord::Migration
  def self.up
    add_column :politicians, :party_leader, :boolean, :default => false
  end

  def self.down
    remove_column :politicians, :party_leader
  end
end
