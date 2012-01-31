require 'spec_helper'

describe Request do
  
  before(:each) do
    @attr = {
      :customer_id => 1,
      :offer_id => 1,
      :status_id => 1,
      :type => "sometype"
    }
  end
  
  it "should create a new instance given valid attributes" do
    @request = Request.create!(@attr)
  end
  
end
