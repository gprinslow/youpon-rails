require 'spec_helper'

describe Status do
  before(:each) do
    @new_attr = { :text => "new" }
    @pending_attr = { :text => "pending" }
  end
  
  it "should create a new instance given valid attributes" do
    @new_status = RequestStatus.create!(@new_attr)
    @pending_status = ValidationStatus.create!(@pending_attr)
  end
end
