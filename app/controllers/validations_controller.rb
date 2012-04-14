class ValidationsController < ApplicationController
  def create
    
    if offer.validation_required?
      #full validation required
    else
      #don't check keycode
    end
  end

end
