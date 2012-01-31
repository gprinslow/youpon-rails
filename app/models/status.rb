class Status < ActiveRecord::Base
  has_many :requests
  has_many :validations, :through => :requests
end
