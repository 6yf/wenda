class Question < ActiveRecord::Base
  validates :name, :presence => true, :length => { :minimum => 10 }
  
  belongs_to :user
  belongs_to :type
  belongs_to :subtype

  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  has_many :tags
  accepts_nested_attributes_for :tags, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
end
