class AddAnswerCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :answer_count, :integer
  end

  def self.down
    remove_column :users, :answer_count
  end
end
