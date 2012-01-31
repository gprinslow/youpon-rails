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
    
    #Added for Offers
    30.times do |n|
      title = Faker::Company.name
      byline = "test-#{n+1}"
      Offer.create!(:title => title,
        :byline => byline,
        :category => "test",
        :discount => "$1",
        :description => "ineffable",
        :terms => "no terms!",
        :start => Time.now,
        :end => Time.now,
        :number_offered => 10,
        :validation_required => true)
    end
    
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
    

    end
  end
end