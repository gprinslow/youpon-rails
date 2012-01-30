class Merchant < ActiveRecord::Base
  has_many :employees, :dependent => :destroy
  has_many :offers, :dependent => :destroy
  has_many :keys, :through => :employees
  
  attr_accessible :name, :description, :phone, :website

	validates :name,
	    :presence => true,
	    :length => { :within => 1..50 },
	    :uniqueness => { :case_sensitive => false }
	
	validates :description,
	    :length => { :within => 0..254 }
	
	phone_regex = /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/
	validates :phone,
	    :format => { :with => phone_regex }
	
	url_regex = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
	validates :website,
	    :format => { :with => url_regex }

end
