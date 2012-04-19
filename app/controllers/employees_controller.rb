class EmployeesController < ApplicationController
  
  #GET /employees
  def index
    @title = "All employees"
    @employees = Employee.all
  end
  
  #GET /employees/1
  def show
    @employee = Employee.find(params[:id])
    @role = Role.find_by_id(@employee.role_id)
    @user = User.find_by_id(@role.user_id)
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @employee }
    end
  end
  
  # GET /employees/new
  def new
    @title = "Employee Sign up"
    @employee = Employee.new
    @merchants = Merchant.all
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @employee }
    end
  end
  
  #GET /employees/1/edit
  def edit
    @employee = Employee.find(params[:id])
    @title = "Update Employee profile"
  end
  
  # POST /employees
  def create
    @employee = Employee.new(params[:employee])
    @role = Role.new
    @role.user_id = current_user.id
    @employee.role = @role
     
    respond_to do |format|
      if @employee.save && @role.save
        format.html  { flash[:success] = "Employee profile updated."; redirect_to current_user }
        format.xml   { render :xml => @employee, :status => :created, :location => @employee }
      else
        format.html  { @title = "Employee Sign up"; render :action => "new" }
        format.xml   { render :xml => @employee.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  #PUT /employees/1
  def update
    @employee = Employee.find(params[:id])
     
    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        format.html  { flash[:success] = "Employee profile updated."; redirect_to @employee }
        format.xml   { head :ok }
      else
        format.html  { @title = "Update Employee profile"; render :action => "edit" }
        format.xml   { render :xml => @employee.errors, :status => :unprocessable_entity }
      end
    end
  end

end
