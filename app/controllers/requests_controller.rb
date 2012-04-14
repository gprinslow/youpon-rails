class RequestsController < ApplicationController
  def create
    respond_to do |format|
		  #so far, only iphone may make requests
		  format.json { 
		    @offer = Offer.find(params[:offer][:id])
		    @user = User.find(params[:user][:id])
		    @customer = Customer.find([:customer][:id])
		    
		    @request = Request.new
		    @status_attr = { :text => "new" }
		    @status = RequestStatus.create!(params[@status_attr])
		    @request.offer = @offer
		    @request.customer = @customer
		    @request.status = @status
		    @request.save!
		    
		    render :json => { :items => @request, :status => :created }
		  }
		end
  end

end
