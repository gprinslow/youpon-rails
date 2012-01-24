class Customer < ActiveRecord::Base
  belongs_to :role
  has_one :user, :through => :role
end
