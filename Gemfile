source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'


# for monitoring of performance
gem 'newrelic_rpm'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'


# authentication
gem 'devise'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production, :staging do
  # heroku requires postgres instead of sqlite
  gem 'pg'
  # heroku says this is a useful gem
  gem 'rails_12factor'
end

# gems for both dev and test
group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # I use this to keep my secret key safely off github
  gem 'dotenv-rails'

  # metrics-based gems
  gem 'flog'       # complexity
  gem 'flay'       # duplication
  gem 'turbulence' # churn vs complexity
  gem 'simplecov'
  # https://github.com/kina/simplecov-rcov-text
  gem 'simplecov-rcov-text'  
  gem 'metric_fu'
end

# test-only gems
group :test do
  # test-running gems
  gem 'term-ansicolor' # colourise the terminla output
  #gem 'turn' #Note: turn doesn't play nice with simplecov
  gem 'shoulda'
  gem 'mocha'
  
  gem 'capybara'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]


ruby '1.9.3'
