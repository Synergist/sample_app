source 'https://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', '1.3.6', :require => 'sqlite3'
gem 'gravatar_image_tag', '0.1.0'

# Gemfile for Rails 3, Sinatra, and Merb
gem 'will_paginate', '~> 3.0'

gem 'autotest'
gem 'autotest-fsevent'
gem 'autotest-growl'
gem 'autotest-rails-pure'


group :development do
  gem 'ZenTest', '~> 4.4.1'
	gem 'rspec-rails', '>= 2.1.0'
	gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
	gem 'faker', '0.3.1'
	gem 'ssl_requirement'
end

group :test do
	gem 'rspec', '>= 2.1.0'
	gem 'webrat', '0.7.1'
	gem 'spork'
	gem 'factory_girl_rails', '1.0'
	gem 'ssl_requirement'
end

group :production do
  # gems for Postgresql to make Heroku work
  gem 'pg'
  gem 'therubyracer', '~> 0.9.3.beta1'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
