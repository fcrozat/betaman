source 'https://rubygems.org'

gem 'rails'
gem 'jquery-rails'
gem 'haml-rails'
gem 'omniauth'
gem 'omniauth-openid'
gem 'mechanize'
gem 'bootstrap-sass', '2.1'
gem 'will_paginate'

# mailmech currently requires colorize
gem 'colorize'

# Production on Heroko requires postgres
gem 'pg' #, '0.12.2'

gem 'passenger'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-datatables-rails', git: 'git://github.com/rweng/jquery-datatables-rails.git'
  gem 'jquery-ui-rails'
end


group :development, :test do
  gem 'hirb'
  gem 'rspec-rails'
  gem 'guard-rspec', '1.2.1'
  gem 'rb-inotify', '~> 0.9'
end
  
group :test do 
  gem 'capybara', '1.1.2'
  gem 'growl', '1.0.3'
  gem 'factory_girl'
  gem 'factory_girl_rails'
end

#gem 'omniauth-google-oauth2'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
