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
              @validation_attr = { :criteria => "entered key == offer.merchant.keys?",
                                   :match => "entered key == offer.merchant.keys" }
              
              @validation = Validation.new(@validation_attr)
              @validation.request = @request
              
              #find the employee who validated
              @employee = Employee.find_by_id(@key_match.employee_id)
              @validation.employee = @employee
              @new_v_status = ValidationStatus.find_by_id(5)
              @new_r_status = RequestStatus.find_by_id(2)
              @request.status = @new_r_status
              @validation.status = @new_v_status
              @request.save!
              @validation.save!
              render :json => { :validation => @validation }
            else #key did not match - invalid
              @validation_attr = { :criteria => "key == entered_key?",
                                   :match => "key x= entered_key" }
              
              @validation = Validation.new(@validation_attr)
              @validation.request = @request
              
              @new_v_status = ValidationStatus.find_by_id(6)
              @new_r_status = RequestStatus.find_by_id(3)
              @request.status = @new_r_status
              @validation.status = @new_v_status
              @request.save!
              @validation.save!
              render :json => { :errors => { :error => @validation.match } } 
            end
          else  #validation is not required - automatically valid
            @validation_attr = { :criteria => "no validation required",
                                 :match => "no validation required" }
            
            @validation = Validation.new(@validation_attr)
            @validation.request = @request
            
            @new_v_status = ValidationStatus.find_by_id(5)
            @new_r_status = RequestStatus.find_by_id(2)
            @request.status = @new_r_status
            @validation.status = @new_v_status
            @request.save!
            @validation.save!
            render :json => { :validation => @validation }
          end
        else #invalid request - not new
          @validation_attr = { :criteria => "request.status == new",
                               :match => "request.status x= new" }
          
          @validation = Validation.new(@validation_attr)
          @validation.request = @request
           
          @new_v_status = ValidationStatus.find_by_id(6)
          @new_r_status = RequestStatus.find_by_id(3)
          @request.status = @new_r_status
          @validation.status = @new_v_status
          @request.save!
          @validation.save!
          render :json => { :errors => { :error => @validation.match } }
        end                 
		  }
		end
  end
end
