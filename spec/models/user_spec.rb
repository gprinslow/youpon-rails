require 'spec_helper'

describe User do
  
	before(:each) do
		@attr = { :email => "test@example.com", 
							:password => "foobar", 
							:password_confirmation => "foobar" }
	end
	
	it "should create a new instance given valid attributes" do
		User.create!(@attr)
	end
end
