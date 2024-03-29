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
      test_sign_in(@user)
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
  
  describe "PUT 'update'" do
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
    
    describe "failure" do
      
      before(:each) do
        @attr = { :name => "", :email => "", :password => "", :password_confirmation => "" }
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end
      
      it "should have the right title" do
        post :update, :id => @user, :user => @attr
        response.should have_selector("title", :content => "Update profile")
      end
    end #end failure
  
    describe "success" do
    
      before(:each) do
        @attr = { :name => "Autotest05", :email => "autotest05@example.com",
                :password => "barfoo", 
                :password_confirmation => "barfoo" }
      end
    
      it "should change the user's attributes" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.name.should  == @attr[:name]
        @user.email.should == @attr[:email]
      end
      
    
      it "should redirect to the user show page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end
      
      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /profile updated/i
      end
    end #end success
  end #end Post create

  describe "authentication of edit/update pages" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    describe "for non-signed-in users" do
      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end
      
      it "should deny access to 'update'" do
         put :update, :id => @user, :user => {}
         response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed-in users" do
      
      before(:each) do
        wrong_user = Factory(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end
      
      it "should require matching users for 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end
      
      it "should require matching users for 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(root_path)
      end
    end
  end #authentication
  
  describe "GET 'index'" do
    
    describe "for not signed in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(root_path)
      end
    end
    
    describe "for signed-in non-admin users" do
      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
      end
      
      it "should deny access" do
        get :index
        response.should redirect_to(root_path)
      end
    end  
    
    describe "for signed-in admin users" do
      
      before(:each) do
        admin_user = Factory(:user, :name => "AtAdmin", :email => "atadmin@example.com")
        admin_user.toggle!(:admin)
        @user = test_sign_in(admin_user)
        second = Factory(:user, :name => "At06", :email => "at06@example.com")
        third = Factory(:user, :name => "At07", :email => "at07@example.com")
        
        @users = [@user, second, third]
        
        30.times do
          @users << Factory(:user, :name => Factory.next(:name), 
                                   :email => Factory.next(:email))
        end
      end
      
      it "should be successful" do
        get :index
        response.should be_success
      end
      
      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "All users")
      end
      
      it "should have an element for each user" do
        get :index
        @users[0..2].each do |user|
          response.should have_selector("li", :content => user.name)
        end
      end
      
      it "should paginate users" do
        get :index
        response.should have_selector("nav", :class => "pagination")
        response.should have_selector("a", :content => "2")
        response.should have_selector("a", :content => "Next")
      end
    end
  end #Get index
  
  describe "DELETE 'destroy'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => @user
        response.should redirect_to(root_path)
      end
    end
    
    describe "as a signed-in non-admin user" do
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @user
        response.should redirect_to(root_path)
      end
    end
    
    describe "as an admin user" do
      
      before(:each) do
        @admin_user = Factory(:user, :name => "AtAdmin", :email => "atadmin@example.com")
        @admin_user.toggle!(:admin)
        test_sign_in(@admin_user)
      end
      
      it "should not allow the admin to seppuku" do
        lambda do
          delete :destroy, :id => @admin_user
        end.should_not change(User, :count).by(-1)
      end
      
      it "should destroy the user" do
        lambda do
          delete :destroy, :id => @user
        end.should change(User, :count).by(-1)
      end
      
      it "should redirect to the users index" do
        delete :destroy, :id => @user
        response.should redirect_to(users_path)
      end
    end
  end #Delete destroy
  
end #end tests
