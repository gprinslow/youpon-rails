require 'spec_helper'

describe Validation do
  
  before(:each) do
    @attr = {
      :criteria => "entered 1 = employee.key?",
      :match => "entered 1 = employee.key=1"
    }
  end
  
  it "should create a new instance given valid attributes", :perf => 1, :frequency => 0.1 do
    @validation = Validation.create!(@attr)
  end
  
  it "should create a new instance given valid attributes", :perf => 2, :frequency => 0.2 do
    @validation = Validation.create!(@attr)
  end
  
end
