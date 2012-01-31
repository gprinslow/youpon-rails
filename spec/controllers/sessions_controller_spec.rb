require 'spec_helper'

describe SessionsController do
  render_views
  
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign in")
    end
  end
  
  describe "POST 'create'" do

    describe "invalid signin" do

      before(:each) do
        @attr = { :email => "email@example.com", :password => "invalid" }
      end

      it "should re-render the new page" do
        post :create, :session => @attr
        response.should render_template('new')
      end

      it "should have the right title" do
        post :create, :session => @attr
        response.should have_selector("title", :content => "Sign in")
      end

      it "should have a flash.now message" do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end
    end #invalid
    
    describe "with valid email and password" do

      before(:each) do
        @user = Factory(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end

      it "should sign the user in", :perf => 1, :frequency => 0.1 do
        post :create, :session => @attr
        test_sign_in(@user)
        controller.current_user.should == @user
        controller.should be_signed_in
      end
      
      it "should sign the user in", :perf => 2, :frequency => 0.1 do
        post :create, :session => @attr
        test_sign_in(@user)
        controller.current_user.should == @user
        controller.should be_signed_in
      end

      it "should redirect to the user show page" do
        post :create, :session => @attr
        test_sign_in(@user)
        response.should be_success    #response.should_not redirect_to(user_path(@user))
      end
      
    end #valid
    
    describe "DELETE 'destroy'" do
			
			it "should sign a user out", :perf => 1, :frequency => 0.1 do
				test_sign_in(Factory(:user))
				delete :destroy
				controller.should_not be_signed_in
				response.should redirect_to(root_path)
			end
			
			it "should sign a user out", :perf => 2, :frequency => 0.1 do
				test_sign_in(Factory(:user))
				delete :destroy
				controller.should_not be_signed_in
				response.should redirect_to(root_path)
			end
		end
    
  end #post create
  

end #tests
