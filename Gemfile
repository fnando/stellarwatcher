source "https://rubygems.org"
ruby "2.5.0"

gem "rails", "5.1.5"

gem "dotenv"
gem "env_vars"
gem "puma"
gem "rails-env"

gem "bcrypt"
gem "pg", "~> 0.18"
gem "ar-uuid"
gem "ar-timestamptz"
gem "ar-check"
gem "encrypt_attr"
gem "normalize_attributes"

gem "sidekiq", require: %w[sidekiq sidekiq/web]
gem "parsel"
gem "aitch"
gem "clockwork"

group :production do
  gem "lograge"
  gem "rails_stdout_logging"
end

group :development do
  gem "check_files"
  gem "foreman"
end

group :test do
  gem "capybara"
  gem "chromedriver-helper"
  gem "launchy"
  gem "minitest-utils"
  gem "selenium-webdriver"
end

group :development, :test do
  gem "pry-meta", require: false
end
