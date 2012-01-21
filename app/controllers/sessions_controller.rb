class SessionsController < ApplicationController
  def new
		@title = "Sign in"
  end

	def create
		user = User.find_by_email(params[:email])
		
		if user && user.authenticate(params[:password])
			sign_in user
			flash[:success] = "Welcome back!"
			redirect_to user
		else
			flash.now[:error] = "Invalid email or password"
			@title = "Sign in"
			render 'new'
		end
	end
	
	def destroy
	  sign_out
	  flash[:notice] = "You have signed out."
		redirect_to root_path
	end

end
