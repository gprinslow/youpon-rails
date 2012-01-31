class SessionsController < ApplicationController
  
  before_filter :not_authenticated_or_admin,  :only => [:new, :create]
  
  def new
		respond_to do |format|
		  format.html { @title = "Sign in" }
		  format.json { head :ok }
		end
  end

	def create
		
			respond_to do |format|
			  format.html { 
			    user = User.find_by_email(params[:email])
			    
			    if user && user.authenticate(params[:password])
			      sign_in user
			      flash[:success] = "Welcome back!";
  			    redirect_back_or user
			    else
			      flash.now[:error] = "Invalid email or password combination."
      			@title = "Sign in"
      			render 'new'
      		end
			  }
			  format.json { 
			    user = User.find_by_email(params[:session][:email])
			    
			    if user && user.authenticate(params[:session][:password])
			      sign_in user
			      render :json => { :items => current_user }
			    else
			      render :json => {:items => {:error => 'invalid email or password'} }
			    end
			  }
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
