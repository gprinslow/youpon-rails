class SessionsController < ApplicationController
  def new
		@title = "Sign in"
  end

	def create
		user = User.find_by_email(params[:email])
		
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			flash[:success] = "Welcome back!"
			redirect_to user
		else
			flash.now.alert = "Invalid email or password"
			render 'new'
		end
	end
	
	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => "Signed out!"
	end

end
