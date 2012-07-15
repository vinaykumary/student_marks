class Result < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :student
end
