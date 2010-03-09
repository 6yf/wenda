class AddQuestionCountToSubtypes < ActiveRecord::Migration
  def self.up
    add_column :subtypes, :question_count, :integer
  end

  def self.down
    remove_column :subtypes, :question_count
  end
end
