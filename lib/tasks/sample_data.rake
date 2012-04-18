require 'faker'

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
    
    #Create Merchants
    merchant1 = Merchant.create!(
      :name => "Merchant 1",
      :description => "Test Merchant 1",
      :phone => "555-555-5555",
      :website => "http://www.example1.com"
    )
    merchant_location1 = Location.create!(
      :address1 => "1123 Washington Ave",
      :city => "St. Louis",
      :state => "MO",
      :zip => "63101"
    )
    merchant1.location = merchant_location1
    
    merchant2 = Merchant.create!(
      :name => "Merchant 2",
      :description => "Test Merchant 2",
      :phone => "111-111-1111",
      :website => "http://www.example2.com"
    )
    merchant_location2 = Location.create!(
      :address1 => "3701 Lindell Blvd",
      :city => "St. Louis",
      :state => "MO",
      :zip => "63108"
    )
    merchant2.location = merchant_location2
    
    #Added for Offers
    10.times do |n|
      title = Faker::Company.bs
      byline = "val-test-#{n+1}"
      category = "Coffee"
      current = Time.now
      starttime = (current - 1.week).to_i
      startdate = Time.at(starttime)
      endtime = (current + 1.week).to_i
      enddate = Time.at(endtime)
      offer = Offer.create!(:title => title,
        :byline => byline,
        :category => category,
        :discount => "$2",
        :description => "ineffable",
        :terms => "no terms!",
        :start => startdate,
        :end => enddate,
        :number_offered => 10,
        :validation_required => true,
        :merchant_id => merchant1.id)
    end
    
    5.times do |n|
      title = Faker::Company.bs
      byline = "noval-test-#{n+1}"
      category = "Haircuts"
      current = Time.now
      starttime = (current - 1.month).to_i
      startdate = Time.at(starttime)
      endtime = (current + 1.month).to_i
      enddate = Time.at(endtime)
      offer = Offer.create!(:title => title,
        :byline => byline,
        :category => category,
        :discount => "$1",
        :description => "ineffable",
        :terms => "no terms!",
        :start => startdate,
        :end => enddate,
        :number_offered => 10,
        :validation_required => false,
        :merchant_id => merchant2.id)
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
    
    #Employees of Merchant 1
    emp_user = User.create!(:name => "Employee A",
                                :email => "emp@eg.com",
                                :password => "foobar",
                                :password_confirmation => "foobar")
    emp_role = Role.create!(:user_id => emp_user.id)
    employee = Employee.create!(:role_id => emp_role.id, 
                                :merchant_id => merchant1.id)
    emp_key = Key.create!(:employee_id => employee.id, :code => "foobarA")
                                                          
    
    mgr_user = User.create!(:name => "Manager B",
                                :email => "mgr@eg.com",
                                :password => "foobar",
                                :password_confirmation => "foobar")
    mgr_role = Role.create!(:user_id => mgr_user.id)
    manager = Manager.create!(:role_id => mgr_role.id, 
                                :merchant_id => merchant1.id)
    mgr_key = Key.create!(:employee_id => manager.id, :code => "foobarB")
    
    #Employees of Merchant 2
    emp2_user = User.create!(:name => "Employee C",
                                :email => "emp2@eg.com",
                                :password => "foobar",
                                :password_confirmation => "foobar")
    emp2_role = Role.create!(:user_id => emp2_user.id)
    employee2 = Employee.create!(:role_id => emp2_role.id, 
                                :merchant_id => merchant2.id)
    emp2_key = Key.create!(:employee_id => employee2.id, :code => "foobarC")
                                                          
    
    mgr2_user = User.create!(:name => "Manager D",
                                :email => "mgr2@eg.com",
                                :password => "foobar",
                                :password_confirmation => "foobar")
    mgr2_role = Role.create!(:user_id => mgr2_user.id)
    manager2 = Manager.create!(:role_id => mgr2_role.id, 
                                :merchant_id => merchant2.id)
    mgr2_key = Key.create!(:employee_id => manager2.id, :code => "foobarD")
    
                                
    30.times do |n|
      name  = Faker::Name.name
      email = "customer-#{n+1}@example.com"
      password  = "foobar"
      cust_user = User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
      cust_role = Role.create!(:user_id => cust_user.id)
      cust_cust = Customer.create!(:role_id => cust_role.id)
    

    end
  end
end