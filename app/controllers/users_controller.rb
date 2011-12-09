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
			flash[:success] = "Welcome to Youpon!"
			redirect_to @user
		else
			@title = "Sign up"
			render 'new'
		end
	end
	
	def show
		@user = User.find(params[:id])
		@title = @user.email
	end
	
end
