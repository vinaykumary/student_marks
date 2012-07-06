class Subject < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :department
  has_many :marks
    attr_protected :id

    scope :dept_sem, lambda{ |dept,sem| { :conditions => ["department_id = ? and semester = ? ", dept, sem], :order => "subject_code" }}

end
