require 'spec_helper'

describe Manager do

  before(:each) do
    @user_attr = {  :name => "autotest01", 
                    :email => "autotest01@example.com", 
                    :password => "foobar", 
                    :password_confirmation => "foobar" }
	end
	
	it "should create a new instance given valid attributes" do
		@manager = Manager.create!
		@user = @manager.create_role.create_user(@user_attr)
	end
	
	describe "role associations" do
	  
	  before(:each) do
	    @manager = Manager.create!
      @user = @manager.create_role.create_user(@user_attr)
    end
    
    it "should have a role attribute" do
      @manager.should respond_to(:role)
    end
    
    it "should have the right associated role" do
      @manager.role_id == @manager.role.id
    end
    
    it "should have a user attribute" do
      @manager.role.should respond_to(:user)
    end
    
    it "should have the right associated user through role" do
      @manager.role.user_id.should == @user.id
      @manager.role.user.should == @user
    end
  end
  
  describe "distinguish from an employee" do
    before(:each) do
      @manager = Manager.create!
      @employee = Employee.create!
      @user = @manager.create_role.create_user(@user_attr)
    end
     
    it "should identify its subclass" do
      @manager.class.should == Manager
    end
     
    it "should identify its parent class" do
      @manager.is_a?(Employee).should be_true
    end
     
    it "should distinguish between managers and non-managers" do
      @employee.is_a?(Manager).should_not be_true
    end
  end
end