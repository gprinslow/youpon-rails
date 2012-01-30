class Employee < ActiveRecord::Base
  belongs_to :role
  belongs_to :merchant
  has_one :user, :through => :role
  has_one :key, :dependent => :destroy
end
