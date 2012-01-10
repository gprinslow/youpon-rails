class User < ActiveRecord::Base

	attr_accessible :email, :password, :password_confirmation

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
