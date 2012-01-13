module SessionsHelper
  
  def sign_in(user)
    #session means it clears when the browser is closed
    session[:remember_token] = [user.id]  
    #if desired can make cookie like below, but to secure it needs authentication + salt in user table
    #cookies.permanent.signed[:remember_token] = [user.id, user.salt]
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    session[:remember_token] = nil
    self.current_user = nil
  end

  private
    def remember_token
      session[:remember_token] || nil
    end
    
    def user_from_remember_token
      ( User.find(session[:remember_token]) if remember_token ) || nil
    end
end   #end module
