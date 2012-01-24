require 'spec_helper'

#belongs_to :user

describe Role do
  
  before(:each) do
    @attr = {
      :user_id => 1
    }
  end
  
  it "should create a new instance given valid attributes" do
    Role.create!(@attr)
  end
  
end
