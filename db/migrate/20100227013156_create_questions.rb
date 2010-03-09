class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :name
      t.references :user
      t.references :type
      t.references :subtype

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
