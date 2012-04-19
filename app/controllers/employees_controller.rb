class EmployeesController < ApplicationController
  
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
  
  # POST /employees
  def create
    @employee = Employee.new(params[:employee])
    @role = Role.new
    @role.user_id = current_user.id
    @employee.role = @role
     
    respond_to do |format|
      if @employee.save && @role.save
        format.html  { flash[:success] = "Employee status updated."; redirect_to current_user }
        format.xml   { render :xml => @employee, :status => :created, :location => @employee }
      else
        format.html  { @title = "Employee Sign up"; render :action => "new" }
        format.xml   { render :xml => @employee.errors, :status => :unprocessable_entity }
      end
    end
  end

end
