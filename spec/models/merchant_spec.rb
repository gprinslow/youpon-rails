require 'spec_helper'

describe Merchant do
  before(:each) do
    @attr = { :name => "Autotest Merchant", 
              :description => "I'm the Autotest provider",
              :phone => "555-555-5555",
              :website => "http://www.example.com" }
  end
  
  it "should create a new instance given valid attributes" do
    Merchant.create!(@attr)
  end
  
  describe "association to employee" do
    
    before(:each) do
      @merchant = Merchant.create!(@attr)
    end
    
    it "should respond to the employees" do
      @merchant.should respond_to(:employees)
    end
  end
    
end
