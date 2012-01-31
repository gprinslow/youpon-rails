class Validation < ActiveRecord::Base 
  belongs_to :request
  belongs_to :employee
  belongs_to :status
end
