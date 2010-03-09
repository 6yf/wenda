class Subtype < ActiveRecord::Base
  validates :name, :presence => true, :length => { :minimum => 2 }
  belongs_to :type
  has_many :questions
end
