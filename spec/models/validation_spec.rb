require 'spec_helper'

describe Validation do
  
  before(:each) do
    @attr = {
      :criteria => "entered 1 = employee.key?",
      :match => "entered 1 = employee.key=1"
    }
  end
  
  it "should create a new instance given valid attributes" do
    @validation = Validation.create!(@attr)
  end
  
end
