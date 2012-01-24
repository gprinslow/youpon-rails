class CustomersController < ApplicationController
  # POST /users
  # POST /users.xml
  def create
    #@user = User.new(params[:user])
    #@customer = @role.create_customer(params[:customer])
    @customer = @role.build_customer(params[:customer])
    
    respond_to do |format|
      if @customer.save
        format.html { flash[:success] = "Welcome to Youpon!"; redirect_to @customer }
        format.xml  { render :xml => @customer, :status => :created, :location => @customer }
        format.json { render :json => {:items => @customer}, :status => :created, :location => @customer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @customer.errors,  :status => :unprocessable_entity }
				format.json { render :json => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end

end
