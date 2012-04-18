namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    #Added for Statuses
    new_status = RequestStatus.create!(:text => "new")
    accepted_status = RequestStatus.create!(:text => "accepted")
    denied_status = RequestStatus.create!(:text => "denied")
    pending_status = ValidationStatus.create!(:text => "pending")
    validated_status = ValidationStatus.create!(:text => "validated")
    invalidated_status = ValidationStatus.create!(:text => "invalidated")
    
    #Create one Merchant for ALL offers
    merchant = Merchant.create!(
      :name => "Merchant 1",
      :description => "Test Merchant 1",
      :phone => "555-555-5555",
      :website => "http://www.example.com"
    )
    merchant_location = MerchantLocation.create!(
      :address1 => "1123 Washington Ave",
      :city => "St. Louis",
      :state => "MO",
      :zip => "63101"
    )
    merchant.location = merchant_location
    
    #Added for Offers
    10.times do |n|
      title = Faker::Company.name
      byline = "test-#{n+1}"
      offer = Offer.create!(:title => title,
        :byline => byline,
        :category => "validation-test",
        :discount => "$1",
        :description => "ineffable",
        :terms => "no terms!",
        :start => Time.now,
        :end => Time.now,
        :number_offered => 10,
        :validation_required => true)
      offer.merchant = merchant
    end
    5.times do |n|
      title = Faker::Company.name
      byline = "NV-test-#{n+1}"
      offer = Offer.create!(:title => title,
        :byline => byline,
        :category => "no-validation-test",
        :discount => "$1",
        :description => "ineffable",
        :terms => "no terms!",
        :start => Time.now,
        :end => Time.now,
        :number_offered => 10,
        :validation_required => false)
      offer.merchant = merchant
    end
    
    admin = User.create!(:name => "Garrison T. Admin",
                         :email => "admin@eg.com",
                         :password => "foobar",
                         :password_confirmation => "foobar")
    admin.toggle!(:admin)
    
    cust_user = User.create!(:name => "Customer",
                                :email => "cust@eg.com",
                                :password => "foobar",
                                :password_confirmation => "foobar")
    cust_role = Role.create!(:user_id => cust_user.id)
    cust_cust = Customer.create!(:role_id => cust_role.id)                        

    emp_user = User.create!(:name => "Employee A",
                                :email => "emp@eg.com",
                                :password => "foobar",
                                :password_confirmation => "foobar")
    emp_role = Role.create!(:user_id => emp_user.id)
    employee = Employee.create!(:role_id => emp_role.id, 
                                :merchant_id => merchant.id)
    emp_key = Key.create!(:employee_id => employee.id, :code => "foobarA")
                                                          
    
    mgr_user = User.create!(:name => "Manager B",
                                :email => "mgr@eg.com",
                                :password => "foobar",
                                :password_confirmation => "foobar")
    mgr_role = Role.create!(:user_id => mgr_user.id)
    manager = Manager.create!(:role_id => mgr_role.id, 
                                :merchant_id => merchant.id)
    mgr_key = Key.create!(:employee_id => manager.id, :code => "foobarB")
    
                                
    20.times do |n|
      name  = Faker::Name.name
      email = "devtest-#{n+1}@example.com"
      password  = "foobar"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    

    end
  end
end