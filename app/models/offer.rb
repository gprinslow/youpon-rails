class Offer < ActiveRecord::Base
  belongs_to :merchant
  has_many :requests
  #has_many :validations, :through => :requests
end
