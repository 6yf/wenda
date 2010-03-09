class AddQuestionCountToTypes < ActiveRecord::Migration
  def self.up
    add_column :types, :question_count, :integer
  end

  def self.down
    remove_column :types, :question_count
  end
end
