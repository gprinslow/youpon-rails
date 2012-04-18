class Offer < ActiveRecord::Base
  belongs_to :merchant
  has_one :location,    :through => :merchant
  has_many :requests
  has_many :validations, :through => :requests
  
  attr_accessible :title, :byline, :category, :discount, :description, :terms, :start, :end, :number_offered, :validation_required
end
