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
      offer1 = Factory(:offer, :title => Factory.next(:title))
      offer2 = Factory(:offer, :title => Factory.next(:title))
      
      @offers = [offer1, offer2]
      
      18.times do
        @offers << Factory(:offer, :title => Factory.next(:title))
      end
      
      10.times do
        @offers << Factory(:offer, :title => Factory.next(:title), :category => Factory.next(:category))
      end
      
      10.times do
        @offers << Factory(:offer, :title => Factory.next(:title), :category => Factory.next(:category))
      end
    end
    
    #PERF=1
    
    it "should list all offers", :perf => 1, :frequency => 0.2 do
      @offers = Offer.all
    end
    
    it "should list offers by category", :perf => 1, :frequency => 0.1 do
      @offers = Offer.find_by_category("testing")
    end
    
    it "should show one offer", :perf => 1, :frequency => 0.2 do
      @offer = Offer.find_by_id(1)
    end
    
    #PERF=2
    
    it "should list all offers", :perf => 2, :frequency => 0.1 do
      @offers = Offer.all
    end
    
    it "should list offers by category", :perf => 2, :frequency => 0.1 do
      @offers = Offer.find_by_category("testing")
    end
    
    it "should show one offer", :perf => 2, :frequency => 0.2 do
      @offer = Offer.find_by_id(1)
    end
  end
end
