class Request < ActiveRecord::Base
  belongs_to :offer
  #belongs_to :status
  #has_many :validations
end
