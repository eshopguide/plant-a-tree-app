source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

# backend
gem 'rails', '~> 6.1.4'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 5.0'
gem 'bootsnap', '>= 1.7.5', require: false
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'dotenv-rails', '~> 2.7'
gem 'sidekiq', '~> 6.2'
gem 'lockbox', '~> 0.6.6'
gem 'redis'

# shopify
gem 'shopify_app', github: 'kirillplatonov/shopify_app'
gem 'polaris_view_components'

# digital humani
gem 'digitalhumani', '~> 0.1.0'

# frontend
gem 'webpacker', '~> 5.0'
gem 'turbo-rails', '~> 0.6.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.0.0'
  gem "factory_bot_rails"
end

group :development do
  gem 'brakeman', require: false
  gem 'foreman', '~> 0.87.2'
  gem 'listen', '~> 3.5'
  gem 'rubocop-rails', require: false
  gem 'rubocop-performance', require: false
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'database_cleaner'
  gem 'rspec-sidekiq'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  gem 'simplecov', require: false
  gem 'webdrivers'
  gem 'webmock', '~> 3.14'
  gem 'vcr'
end
