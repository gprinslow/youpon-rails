require 'spec_helper'

#belongs_to :role
#has_one :user, :through => :role

describe Customer do
  
  before(:each) do
    @user_attr = {  :name => "autotest01", 
                    :email => "autotest01@example.com", 
                    :password => "foobar", 
                    :password_confirmation => "foobar" }
	end
	
	it "should create a new instance given valid attributes" do
		@customer = Customer.create!
		@user = @customer.create_role.create_user(@user_attr)
	end
	
	describe "role associations" do
	  
	  before(:each) do
	    @customer = Customer.create!
      @user = @customer.create_role.create_user(@user_attr)
    end
    
    it "should have a role attribute" do
      @customer.should respond_to(:role)
    end
    
    it "should have the right associated role" do
      @customer.role_id == @customer.role.id
    end
    
    it "should have a user attribute" do
      @customer.role.should respond_to(:user)
    end
    
    it "should have the right associated user through role" do
      @customer.role.user_id.should == @user.id
      @customer.role.user.should == @user
    end
  end
end