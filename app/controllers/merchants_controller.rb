class MerchantsController < ApplicationController
  def new
    @title = "Merchant Sign up"
    @merchant = Merchant.new
    @location = MerchantLocation.new
    @merchant.location = @location
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @merchant }
    end
  end

end
