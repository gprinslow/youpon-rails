require 'spec_helper'

describe "Users" do

  describe "signup" do
    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit signup_path 
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button   
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")    
        end.should_not change(User, :count)
      end
    end #failure
    
    describe "success" do  
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "Autotest04"
          fill_in "Email",        :with => "autotest04@example.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button      
          response.should have_selector("div.flash.success", :content => "Welcome")
          response.should render_template('users/show')     
        end.should change(User, :count).by(1)
      end
    end #success
    
  end #signup
  
  describe "sign in/out" do
    describe "failure" do
			it "should not sign a user in" do
				visit signin_path
				user = Factory(:user)
				user.email = ""
				user.password = ""
				integration_sign_in(user)
				response.should have_selector("div.flash.error", :content => "Invalid")
			end
		end
		
		describe "success" do
			it "should sign a user in and out" do
				user = Factory(:user)
				integration_sign_in(user)
				controller.should be_signed_in
				click_link "Sign out"
				controller.should_not be_signed_in
			end
		end
	end #sign in/out
	
	describe "destination forwarding" do
	  
	  it "should forward to the requested page after signin" do
	    user = Factory(:user)
	    visit edit_user_path(user)
	    #the test goes to signin page
	    fill_in :email,     :with => user.email
	    fill_in :password,  :with => user.password
	    click_button
	    #the test goes to users/edit
	    response.should render_template('users/edit')
	  end
  end
  
end #user integration tests
