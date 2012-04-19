class OffersController < ApplicationController
  def index
    @offers = Offer.order(:title).page params[:page]
    
    respond_to do |format|
      format.html {
         if employee?(current_user)
           @merchant = current_merchant
           @offers = @merchant.offers.order(:title).page params[:page]
         end
      }
      format.xml  { render :xml => @offers }
      format.json { render :json => { :offers => @offers } }
    end
  end
  
  def show
    @offer = Offer.find(params[:id])
    
    respond_to do |format|
      format.html #show
      format.xml  { render :xml => @offer }
      format.json { render :json => { :offer => @offer, :location => @offer.location } }
    end
  end
  
  # GET /offers/new
  # GET /offers/new.xml
  def new
    @offer = Offer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @offer }
    end
  end

  # GET /offers/1/edit
  def edit
    @offer = Offer.find(params[:id])
  end

  # POST /offers
  # POST /offers.xml
  def create
    @offer = Offer.new(params[:offer])

    respond_to do |format|
      if @offer.save
        format.html { redirect_to(@offer, :notice => 'Offer was successfully created.') }
        format.xml  { render :xml => @offer, :status => :created, :location => @offer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @offer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /offers/1
  # PUT /offers/1.xml
  def update
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        format.html { redirect_to(@offer, :notice => 'Offer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @offer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.xml
  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy

    respond_to do |format|
      format.html { redirect_to(offers_url) }
      format.xml  { head :ok }
    end
  end
end
