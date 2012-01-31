require 'spec_helper'

describe User do
  describe "Scenario 1: New User test" do
    
    before(:each) do
      #all setup for each test
      @user_attr = {
        :name => "auto-newuser",
        :email => "auto-newuser@example.com",
        :password => "foobar",
        :password_confirmation => "foobar"
      }
      
      @request_attr = {
        :customer_id => 1,
        :offer_id => 1,
        :status_id => 1,
        :type => "testing"
      }
      
      @validation_attr = {
        :type => "testing",
        :criteria => "test=test?",
        :match => "test=test"
      }
    end

    it "should create a user" do
      @customer = Customer.create!
      @user = @customer.create_role.create_user(@user_attr)
    end
    
    it "should create a session" do
      test_sign_in(@user)
    end
    
    it "should list all offers" do
      @all_offers = Offers.all
    end
    
    it "should find offers by category" do
      @cat_offers = Offers.find_by_category("testing")
    end
    
    it "should show one offer" do
      @offer = Offers.find_by_id(1)
    end
    
    it "should create a redemption request" do
      @customer.create_request(@request_attr)
    end
    
    it "should create a validation" do
      @validation = KeyValidation.create!(@validation_attr)
    end
    
  end
end
