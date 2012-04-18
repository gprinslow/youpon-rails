require 'spec_helper'

describe Location do
  before(:each) do
    @loc_attr = {  :address1 => "autotest01", 
                    :address2 => "autotest01", 
                    :city => "Foobar", 
                    :state => "MO",
                    :zip => "63101" }
	end
	
	it "should create a new instance given valid attributes" do
		@location = Location.create!(@loc_attr)
	end
end
