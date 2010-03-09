class CreateSubtypes < ActiveRecord::Migration
  def self.up
    create_table :subtypes do |t|
      t.string :name
      t.references :type

      t.timestamps
    end
  end

  def self.down
    drop_table :subtypes
  end
end
