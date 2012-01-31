class Request < ActiveRecord::Base
  belongs_to :customer
  belongs_to :offer
  belongs_to :status
  has_one :validation
end
