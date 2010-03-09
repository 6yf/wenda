class AddAnswerCountToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :answer_count, :integer
  end

  def self.down
    remove_column :questions, :answer_count
  end
end
