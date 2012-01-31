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
  
  it "should create a new instance given valid attributes", :perf => 1, :frequency => 0.1 do
    @request = Request.create!(@attr)
  end
  
  it "should create a new instance given valid attributes", :perf => 2, :frequency => 0.2 do
    @request = Request.create!(@attr)
  end
  
end
