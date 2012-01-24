require 'spec_helper'

#belongs_to :role
#has_one :user, :through => :role

describe Customer do
  before(:each) do
    @user = Factory(:user)
	end
	
	it "should create a new instance given valid attributes" do
		Customer.create!
	end
end
