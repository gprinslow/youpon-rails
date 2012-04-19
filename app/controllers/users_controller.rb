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
    respond_to do |format|
      format.html {
        @user = User.find(params[:id])
        @role = Role.find_by_user_id(@user.id)  
        @title = @user.email
      }
      format.xml  { 
        @user = User.find(params[:id])
        @role = Role.find_by_user_id(@user.id)
        render :xml => @user 
      }
      format.json {    
        @user = User.find(params[:id])
        @role = Role.find_by_user_id(@user.id)
        @customer = Customer.find_by_role_id(@role.id)
        render :json => { :items => { :user => @user, :customer => @customer } }
      }
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
    respond_to do |format|
      format.html {
        @role = Role.new
        @user = @role.build_user(params[:user])
        #note-how to resolve with Customer/Merchant/Employee etc.?
        if @user.save
          sign_in @user
          flash[:success] = "Welcome to Youpon!"
          redirect_to @user
        else 
          @title = "Sign up"
          @user.password = ""
          @user.password_confirmation = ""
          render :action => "new"
        end
      }
      format.xml {
        @role = Role.new
        @user = @role.build_user(params[:user])
        #note-how to resolve with Customer/Merchant/Employee etc.?
        if @user.save
          sign_in @user
          render :xml => @user, :status => :created, :location => @user
        else
          render :xml => @user.errors,  :status => :unprocessable_entity
        end
      }
      format.json {          
        #this assumes that json only comes from iphone and iphone users are Customers on signup
        @user = User.new(params[:user])
        @customer = Customer.new
        @role = Role.new
        @user.role = @role
        @customer.role = @role
        
        if @user.save && @role.save && @customer.save
          sign_in @user
          render :json => { :items => { :user => @user, :customer => @customer }, :status => :created }
        else
          render :json => { :errors => @user.errors, :status => :unprocessable_entity }
        end
      }
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
				format.json { render :json => { :items => @user }, :status => :ok }
      else
        format.html { @title = "Update profile"; render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
				format.json { render :json => { :errors => @user.errors }, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])

    respond_to do |format|
      if current_user != @user
        @user.destroy
        format.html { flash[:notice] = "User deleted."; redirect_to(users_path) }
        format.xml  { head :ok }
  			format.json { render :json => { :items => @user }, :status => :ok }
      else
        format.html { flash[:error] = "Cannot perform seppuku."; redirect_to(users_path) }
        format.xml  { render :xml => @user.errors,  :status => :unprocessable_entity }
				format.json { render :json => { :errors => @user.errors }, :status => :unprocessable_entity }
			end
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
