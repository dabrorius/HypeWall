source 'https://rubygems.org'

group :production do
  # Heroku assets
  gem 'rails_12factor'
end

gem 'friendly_id', '~> 5.0.0' 
# Track performance
gem 'newrelic_rpm'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

gem 'font-awesome-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development
gem 'instagram'
gem 'dotenv-rails', :groups => [:development, :test]

# User authentication
gem 'devise'

# File upload manager
gem "paperclip", :git => "git://github.com/thoughtbot/paperclip.git"

gem "activerecord-session_store"

# Two way comunication with browser
gem 'websocket-rails'

# Amazon web services (uploading stuff on heroku)
gem 'aws-sdk'

group :test do
  gem "minitest"
  gem 'rspec-rails', '~> 3.0.0'
  gem 'capybara', '2.2.0'
  gem 'poltergeist', '1.5.0'
  gem 'factory_girl_rails', '4.2.1'
  gem 'shoulda-context', '~> 1.0.2'
  gem 'shoulda-matchers', '~> 2.3.0'
  gem 'simplecov', '0.7.1'
  gem 'webmock', '~>1.17.0'
end

gem 'fastspring-saasy'
