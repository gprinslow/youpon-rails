class RequestsController < ApplicationController
  def create
    respond_to do |format|
		  format.json { 
		    offer = Offer.find(params[:offer][:id])
		    
		    #get customer_id through user_id query on role ->
		    
		    if offer.validation_required?
		      #full validation required
		    else
		      #don't check keycode
		    end
		  }
		end
  end

end
