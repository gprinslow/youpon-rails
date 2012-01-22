require 'spec_helper'

describe UsersController do
	render_views

  describe "GET 'new'" do
		it "returns http success" do
      get 'new'
      response.should be_success
    end
		
		it "should have the right title" do
			get 'new'
			response.should have_selector("title", :content => "Sign up")
		end
  end

  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "should include the user's email in the title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.email)
    end

    it "should have a h1 that says Profile" do
      get :show, :id => @user
      response.should have_selector("h1", :content => "Profile")
    end

    it "should have a profile image under h2" do
      get :show, :id => @user
      response.should have_selector("h2>img", :class => "gravatar")
    end
  end


  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = { :name => "", :email => "", :password => "", 
                  :password_confirmation => "" }
      end
      
      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
      
      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Sign up")
      end
      
      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    
    end #end failure
  
    describe "success" do
    
      before(:each) do
        @attr = { :name => "Autotest03", :email => "autotest03@example.com",
                :password => "foobar", 
                :password_confirmation => "foobar" }
      end
    
      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      
			it "should sign the user in" do
				post :create, :user => @attr
				controller.should be_signed_in
			end
    
      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to youpon/i
      end
    end #end success
  
  end #end Post create
  
  describe "GET 'edit'" do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @user
      response.should have_selector("title", :content => "Update profile")
    end

    it "should have a link to change the Gravatar" do
      get :edit, :id => @user
      gravatar_url = "http://gravatar.com/emails"
      response.should have_selector("a", :href => gravatar_url, :content => "change")
    end
  end #end Get edit

end #end tests
