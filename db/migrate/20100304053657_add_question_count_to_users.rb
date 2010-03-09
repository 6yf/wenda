class AddQuestionCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :question_count, :integer
  end

  def self.down
    remove_column :users, :question_count
  end
end
