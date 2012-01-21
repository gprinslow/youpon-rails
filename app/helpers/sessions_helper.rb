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
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    session[:remember_token] = nil
    self.current_user = nil
  end

  private
    def user_from_remember_token
      ( User.find(session[:remember_token]) if remember_token ) || nil
    end
    
    def remember_token
      session[:remember_token] || nil
    end
  #end private
end   #end module
