require 'spec_helper'

describe User do
  
	before(:each) do
		@attr = { :name => "autotest01",
		          :email => "autotest01@example.com", 
							:password => "foobar", 
							:password_confirmation => "foobar" }
	end
	
	it "should create a new instance given valid attributes" do
		User.create!(@attr)
	end
	
	describe "admin attribute" do
	  
	  before(:each) do
	    @user = User.create!(@attr)
	  end
	  
	  it "should respond to admin" do
	    @user.should respond_to(:admin)
	  end
	  
	  it "should not be an admin by default" do
	    @user.should_not be_admin
	  end
	  
	  it "should be convertible to an admin" do
	    @user.toggle!(:admin)
	    @user.should be_admin
	  end
	end
	
	describe "role association" do
	  
	  before(:each) do
	    @user = User.create(@attr)
	  end
	  
	  it "should have a role attribute" do
	    @user.should respond_to(:role)
	  end
	end
	  
end
