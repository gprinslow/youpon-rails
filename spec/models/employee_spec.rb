require 'spec_helper'

describe Employee do
  
  before(:each) do
    @user_attr = {  :name => "autotest01", 
                    :email => "autotest01@example.com", 
                    :password => "foobar", 
                    :password_confirmation => "foobar" }
	end
	
	it "should create a new instance given valid attributes" do
		@employee = Employee.create!
		@user = @employee.create_role.create_user(@user_attr)
	end
	
	describe "role associations" do
	  
	  before(:each) do
	    @employee = Employee.create!
      @user = @employee.create_role.create_user(@user_attr)
    end
    
    it "should have a role attribute" do
      @employee.should respond_to(:role)
    end
    
    it "should have the right associated role" do
      @employee.role_id == @employee.role.id
    end
    
    it "should have a user attribute" do
      @employee.role.should respond_to(:user)
    end
    
    it "should have the right associated user through role" do
      @employee.role.user_id.should == @user.id
      @employee.role.user.should == @user
    end
  end
end
