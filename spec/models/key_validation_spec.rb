require 'spec_helper'

describe KeyValidation do

  before(:each) do
    @attr = {
      :criteria => "entered 1 = employee.key?",
      :match => "entered 1 = employee.key=1"
    }
  end
  
  it "should create a new instance given valid attributes" do
    @key_validation = KeyValidation.create!(@attr)
  end

end
