class MerchantsController < ApplicationController
  #GET /merchants
  def index
    @title = "All merchants"
    @merchants = Merchant.order(:name).page params[:page]
  end
  
  #GET /merchants/1
  def show
    @merchant = Merchant.find(params[:id])
    @location = @merchant.location
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @merchant }
    end
  end
  
  #GET /merchants/new
  def new
    @title = "Merchant Sign up"
    @merchant = Merchant.new
    @merchant.build_location
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @merchant }
    end
  end
  
  #GET /merchants/1/edit
  def edit
    @merchant = Merchant.find(params[:id])
    @title = "Update Merchant profile"
  end
  
  #POST /merchants
  def create
    @merchant = Merchant.new(params[:merchant])
    
    respond_to do |format|  
      if @merchant.save 
        format.html { flash[:success] = "Merchant created."; redirect_to new_employee_path }
        format.xml { render :xml => @merchant, :status => :created, :location => @merchant }
      else
        format.html { @title = "Merchant Sign up"; render :action => "new" }
        format.xml { render :xml => @merchant.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  #PUT /merchants/1
  def update
    @merchant = Merchant.find(params[:id])
    
    respond_to do |format|
      if @merchant.update_attributes(params[:merchant])
        format.html { flash[:success] = "Merchant profile updated."; redirect_to @merchant }
        format.xml  { head :ok }
      else
        format.html { @title = "Update Merchant profile"; render :action => "edit" }
        format.xml  { render :xml => @merchant.errors, :status => :unprocessable_entity }
      end
    end    
  end
end
