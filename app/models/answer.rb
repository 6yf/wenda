class Answer < ActiveRecord::Base
  validates :name, :presence => true, :length => { :minimum => 2 }
  
  belongs_to :question
  belongs_to :user
end
