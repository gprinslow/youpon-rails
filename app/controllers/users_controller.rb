class UsersController < ApplicationController
  def new
		@title = "Sign up"
		@user = User.new
		
		respond_to do |format|
			format.html	# new.html.erb
			format.xml 	{ render :xml => @user }
		end
  end

	def create
		@user = User.new(params[:user])
		if @user.save
			redirect_to root_url, :notice => "Signed up!"
		else
			render "new"
		end
	end
	
	def show
		@user = User.find(params[:id])
		@title = @user.email
	end
	
end
