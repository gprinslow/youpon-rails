class ReportsController < ApplicationController
  def index
     @merchant = current_merchant
     @offers = @merchant.offers.order(:title).page params[:page]
  end
end
