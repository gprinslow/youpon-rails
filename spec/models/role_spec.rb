require 'spec_helper'

#belongs_to :user

describe Role do
  
  before(:each) do
    @attr = { :name => "autotest01",
		          :email => "autotest01@example.com", 
							:password => "foobar", 
							:password_confirmation => "foobar" }
  end
  
  it "should create a new instance given valid attributes" do
    @role = Role.create!
    @user = @role.create_user(@attr)
  end
  
  describe "user associations" do
    
    before(:each) do
      @role = Role.create!
      @user = @role.create_user(@attr)
    end
    
    it "should have a user attribute" do
      @role.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @role.user_id.should == @user.id
      @role.user.should == @user
    end
  end
end
