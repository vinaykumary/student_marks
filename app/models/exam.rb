class Exam < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :department
    has_many :marks
    attr_protected :id

end
