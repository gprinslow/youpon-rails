source 'http://rubygems.org'

gem 'rails', '3.1.2'
gem 'sqlite3'
gem 'jquery-rails'

gem 'gravatar_image_tag'
gem 'kaminari'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5.rc.2'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
	gem 'rspec-rails'
	gem 'annotate'
	gem 'faker'
	gem 'thin'
end

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
	gem 'rspec-rails'
	gem 'webrat'
	gem 'autotest'
	gem 'autotest-rails-pure'
	gem 'autotest-fsevent'
	gem 'autotest-growl'
	gem 'factory_girl_rails'
	gem 'spork'
	gem 'thin'
end

group :production do
  # gems specifically for Heroku go here
  gem 'pg'
end
