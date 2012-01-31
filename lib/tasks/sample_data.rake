namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Garrison T. Admin",
                         :email => "admin@eg.com",
                         :password => "foobar",
                         :password_confirmation => "foobar")
    admin.toggle!(:admin)
    user = User.create!(:name => "Normal User",
                                :email => "user@eg.com",
                                :password => "foobar",
                                :password_confirmation => "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "devtest-#{n+1}@example.com"
      password  = "foobar"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    
    #Added for Statuses
    new_status = Status.create!(:type => "RequestStatus", :text => "New")
    approved_status = Status.create!(:type => "")
    end
  end
end