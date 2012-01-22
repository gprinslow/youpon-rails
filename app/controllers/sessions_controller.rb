class SessionsController < ApplicationController
  
  before_filter :not_authenticated_or_admin,  :only => [:new, :create]
  
  def new
		respond_to do |format|
		  format.html { @title = "Sign in" }
		  format.json { head :ok }
		end
  end

	def create
		user = User.find_by_email(params[:email])
		
		if user && user.authenticate(params[:password])
			sign_in user
			respond_to do |format|
			  format.html { flash[:success] = "Welcome back!"; redirect_back_or user }
			  format.json { render :json => { :items => current_user } }
			end
		else
			respond_to do |format|
			  format.html {
			    flash.now[:error] = "Invalid email or password combination."
    			@title = "Sign in"
    			render 'new'
			  }
        format.json {
          render :json => {:items => {:error => 'invalid email or password'} }
        }
      end
		end
	end
	
	def destroy
	  sign_out
	  flash[:notice] = "You have signed out."
		redirect_to root_path
	end
	
	private
	  def not_authenticated_or_admin
      if signed_in? && !current_user.admin?
        flash[:success] = "You are currently signed in."
        redirect_to(current_user)
      end
    end
  #end private
end
