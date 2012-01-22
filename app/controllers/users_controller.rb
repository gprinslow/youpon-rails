#require "rexml/document"

class UsersController < ApplicationController


  before_filter :authenticated,               :only => [:show, :edit, :update]
  before_filter :authenticated_admin,         :only => [:index, :destroy]
  before_filter :correct_user_or_admin,       :only => [:show, :edit, :update]  
  before_filter :not_authenticated_or_admin,  :only => [:new, :create]

  #GET /users
  def index
    @title = "All users"
    @users = User.order(:name).page params[:page]
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @title = @user.email
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
      format.json { render :json => {:items => @user }}
    end
	end

  # GET /users/new
  # GET /users/new.xml
  def new
    @title = "Sign up"
    @user = User.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  # GET /users/1/edit
	def edit
	  @user = User.find(params[:id])
	  @title = "Update profile"
	end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        format.html { sign_in @user; flash[:success] = "Welcome to Youpon!"; redirect_to @user }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
        format.json { sign_in @user; render :json => {:items => @user}, :status => :created, :location => @user }
      else
        @title = "Sign up"
        @user.password = ""
        @user.password_confirmation = ""
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors,  :status => :unprocessable_entity }
				format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { flash[:success] = "Profile updated."; redirect_to @user }
        format.xml  { head :ok }
				format.json { render :json => @user, :status => :ok }
      else
        format.html { @title = "Update profile"; render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
				format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])

    respond_to do |format|
      format.html { 
          if current_user == @user
            flash.now[:error] = "I forbid you from performing seppuku!"
            redirect_to(users_path)
          else
            @user.destroy
            flash[:notice] = "User destroyed."
            redirect_to(users_path)
          end
        }
      #format.xml  { head :ok }
			#format.json { render :json => @user, :status => :ok }
    end
  end
	
	private
	  def authenticated
	    deny_access unless signed_in?
	  end
	  
	  def authenticated_admin
	    redirect_to(root_path) unless signed_in? && current_user.admin?
	  end
	  
	  def correct_user_or_admin
	    @user = User.find(params[:id])
	    redirect_to(root_path) unless current_user?(@user) || current_user.admin?
	  end
	  
	  def not_authenticated_or_admin
	    if signed_in? && !current_user.admin?
	      flash[:notice] = "You are currently signed in. Please sign out first."
	      redirect_to(current_user)
	    end
	  end
end
