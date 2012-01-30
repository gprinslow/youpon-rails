require 'spec_helper'

#belongs_to :employee

describe Key do
  
  before(:each) do
    @attr = { :type => "simple",
              :code => "0000" }
  end
  
  it "should create a new instance given valid attributes" do
    @key = Key.create!(@attr)
  end
  
  describe "employee association" do
    
    before(:each) do
      @employee = Employee.create!
      @key = @employee.build_key(@attr)
    end
    
    it "should have an employee attribute" do
      @key.should respond_to(:employee)
    end
    
    it "should build a key and associate correctly from employee instance" do
      @key.employee_id.should == @employee.id
      @key.employee.should == @employee
    end
  end
end
