class Merchant < ActiveRecord::Base
  has_many :employees, :dependent => :destroy
  #has_many :offers, :dependent => :destroy
end
