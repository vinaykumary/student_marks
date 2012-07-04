class Department < ActiveRecord::Base
  attr_protected :id

  has_many :students
  has_many :exams
  has_many :subjects
  # attr_accessible :title, :body
end
