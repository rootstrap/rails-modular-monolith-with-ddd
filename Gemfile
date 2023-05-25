source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.0.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Compile and serve assets
gem 'sprockets-rails', '~> 3.4.2'
# Use Bootstrapp for stylesheets
gem 'cssbundling-rails', '~> 1.0.0'
# Transpile app-like JavaScript
gem 'jsbundling-rails', '~> 1.0.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Authentication
gem 'devise', '~> 4.8'

gem 'karafka', '~> 2.0'

group :development, :test do
  gem 'byebug', '~> 11.1.3'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry-remote', require: 'pry-remote'
  # Modularization
  gem 'packwerk', '~> 2.2'
  # Visual representation of components
  gem 'graphwerk', '~> 1.2.0'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.19'
  gem 'dotenv-rails', '~> 2.7', '>= 2.7.6'
end

group :test do
  gem 'karafka-testing', '~> 2.0.6'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'rspec-rails', '~> 5.0', '>= 5.0.2'
  gem 'super_diff', '~> 0.9.0'
end

group :development do
  # Annotate models
  gem 'annotate', '~> 3.2.0'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'letter_opener', '~> 1.4', '>= 1.4.1'
  gem 'mailcatcher'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
