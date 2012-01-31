require 'spec_helper'

describe Offer do
  
  before(:each) do
    @attr = {
      :title => "title",
      :byline => "byline",
      :category => "test coupons",
      :discount => "$1",
      :description => "ineffable",
      :terms => "no terms!",
      :start => Time.now,
      :end => Time.now,
      :number_offered => 10,
      :validation_required => true 
      }
  end
  
  it "should create a new instance given valid attributes" do
    @offer = Offer.create!(@attr)
  end
  
  describe "merchant association" do
    
    before(:each) do
      @offer = Offer.create!(@attr)
    end
    
    it "should have a merchant attribute" do
      @offer.should respond_to(:merchant)
    end
  end
  
  describe "performance testing" do
    
    before(:each) do
      20.times do
        @offers << Factory(:offer, :title => Factory.next(:title))
      end
    end
    
    it "should list all offers"
  end
end
