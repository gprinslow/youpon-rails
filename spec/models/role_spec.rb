require 'spec_helper'

#belongs_to :user

describe Role do
  
  before(:each) do
    @user = Factory(:user)
  end
  
  it "should create a new instance given valid attributes" do
    @user.role.create!
  end
  
  describe "user associations" do
    
    before(:each) do
      @role = @user.role.create
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
