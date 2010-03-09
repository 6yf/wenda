class AddViewCountToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :view_count, :integer, :default => 0
  end

  def self.down
    remove_column :answers, :view_count
  end
end
