class ApplicationController < ActionController::Base
  protect_from_forgery
	#This forces https in test and production
	#force_ssl
	
	#This is a fugly way to keep the app somewhat private
	#http_basic_authenticate_with :name => "gprinslow", :password => "asdfFoobar1234"
	
	include SessionsHelper
	private
	
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	helper_method :current_user
end
