class RequestsController < ApplicationController
  def create
    respond_to do |format|
		  #so far, only iphone may make requests
		  format.json { 
		    @offer = Offer.find(params[:offer][:id])
		    @user = User.find(params[:user][:id])
		    @customer = Customer.find(params[:customer][:id])
		    
		    @request = Request.new
		    @status = Status.find_by_id(1)
		    @request.offer = @offer
		    @request.customer = @customer
		    @request.status = @status
		    @request.save!
		    
		    render :json => { :items => @request, :status => :created }
		  }
		end
  end

end
