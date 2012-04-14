class ValidationsController < ApplicationController
  def create
    respond_to do |format|
		  #so far, only iphone may make requests
		  format.json { 
		    @request = Request.find(params[:validation_request][:request][:items][:id])
		    
		    @offer = Offer.find(params[:validation_request][:request][:items][:offer_id])
        @current_status = Status.find(params[:validation_request][:request][:items][:status_id])    
		    
		    @validation = Validation.new
        @validation.request = @request
        
        if @current_status.id = 1   #new
          if @offer.validation_required?
            @key_match = Key.find_by_code(params[:validation_request][:key_entry])
            if @key_match
              #find the employee who validated
              @employee = Employee.find_by_id(@key_match.employee_id)
              @validation.employee = @employee
              @new_v_status = ValidationStatus.find_by_id(5)
              @new_r_status = RequestStatus.find_by_id(2)
              @request.status = @new_r_status
              @validation.status = @new_v_status
              #@validation.critera = "entered key == offer.merchant.keys?"
              #@validation.match = "entered key == offer.merchant.keys"
              @request.save!
              @validation.save!
              render :json => { :validation => @validation }
            else #key did not match - invalid
              @new_v_status = ValidationStatus.find_by_id(6)
              @new_r_status = RequestStatus.find_by_id(3)
              @request.status = @new_r_status
              @validation.status = @new_v_status
              @validation.critera = "key == entered_key?"
              @validation.match = "key x= entered_key"
              @request.save!
              @validation.save!
              render :json => { :errors => @new_v_status } 
            end
          else  #validation is not required - automatically valid
            @new_v_status = ValidationStatus.find_by_id(5)
            @new_r_status = RequestStatus.find_by_id(2)
            @request.status = @new_r_status
            @validation.status = @new_v_status
            @validation.critera = "no validation required"
            @validation.match = "no validation required"
            @request.save!
            @validation.save!
            render :json => { :validation => @validation }
          end
        else #invalid request - not new
           @new_v_status = ValidationStatus.find_by_id(6)
           @new_r_status = RequestStatus.find_by_id(3)
           @request.status = @new_r_status
           @validation.status = @new_v_status
           @validation.critera = "request.status == new"
           @validation.match = "request.status x= new"
           @request.save!
           @validation.save!
           render :json => { :errors => @new_v_status }
        end                 
		  }
		end
  end
end
