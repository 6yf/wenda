class Type < ActiveRecord::Base
  validates :name, :presence => true, :length => { :minimum => 2 }
  has_many :subtypes
 
  accepts_nested_attributes_for :subtypes, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } } 
end
