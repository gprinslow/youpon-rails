class ApplicationController < ActionController::Base
  protect_from_forgery
	#This forces https in test and production
	#force_ssl
	
	#This is a fugly way to keep the app somewhat private
	#http_basic_authenticate_with :name => "gprinslow", :password => "asdfFoobar1234"
	
	include SessionsHelper

end
