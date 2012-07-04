class Mark < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :subject
  belongs_to :exam
  belongs_to :student
    attr_protected :id

end
