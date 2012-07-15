class Student < ActiveRecord::Base
  belongs_to :department
  has_many :marks
  has_many :results
  attr_accessible :Department, :Exam, :Mark
    attr_protected :id
  scope :dept_sem, lambda{ |dept,sem| { :conditions => ["department_id = ? and semester = ? ", dept, sem], :order => "roll_no" }}
end
