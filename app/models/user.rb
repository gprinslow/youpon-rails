class User < ActiveRecord::Base

  has_one :role

	attr_accessible :name, :email, :password, :password_confirmation, :birthday, :gender

	validates :name,
	    :presence => true,
	    :length => { :within => 1..100 }

	email_regex =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, 
			:presence => true, 
			:format => { :with => email_regex },
			:uniqueness => { :case_sensitive => false }
	
	has_secure_password
	validates :password, 
			:presence => true, 
			:on => :create,
			:length => { :within => 6..20 }


end
