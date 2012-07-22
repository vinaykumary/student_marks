class User < ActiveRecord::Base
  attr_accessible :password, :password_confirmation, :username
  has_secure_password
  validates_presence_of :password
end
