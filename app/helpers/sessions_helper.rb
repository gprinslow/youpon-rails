module SessionsHelper
  
  def sign_in(user)
    #session means it clears when the browser is closed
    #session[:user_id] = user.id
    session[:remember_token] = user.id
    self.current_user = user
    #if desired can make cookie like below, but to secure it needs authentication + salt in user table
    #cookies.permanent.signed[:remember_token] = [user.id, user.salt]
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def customer?(user)
    Customer.find_by_role_id(user.role.id) != nil 
  end
  
  def employee?(user)
    Employee.find_by_role_id(user.role.id) != nil
  end
  
  def manager?(user)
    employee = Employee.find_by_role_id(user.role.id)
    if employee != nil
      employee.is_manager?
    else
      false
    end
  end
  
  def current_employee
    Employee.find_by_role_id(current_user.role.id)
  end
  
  def current_merchant
    Merchant.find_by_id(current_employee.merchant_id)
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    session[:remember_token] = nil
    self.current_user = nil
  end

  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  private
    def user_from_remember_token
      ( User.find(session[:remember_token]) if remember_token ) || nil
    end
    
    def remember_token
      session[:remember_token] || nil
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def clear_return_to
      session[:return_to] = nil
    end
  #end private
end   #end module
