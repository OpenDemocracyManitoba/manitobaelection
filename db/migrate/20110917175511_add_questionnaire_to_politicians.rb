class AddQuestionnaireToPoliticians < ActiveRecord::Migration
  def self.up
    add_column :politicians, :questionnaire, :text
  end

  def self.down
    remove_column :politicians, :questionnaire
  end
end
