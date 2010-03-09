class AddViewCountToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :view_count, :integer, :default => 0
  end

  def self.down
    remove_column :questions, :view_count
  end
end
