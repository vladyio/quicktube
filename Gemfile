source "https://rubygems.org"

ruby file: ".ruby-version"

gem "importmap-rails"
gem "propshaft"
gem "puma"
gem "rails", "~> 7.2", ">= 7.2.1"
gem "redis"
gem "sidekiq"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"

gem "bootsnap", require: false
gem "ostruct", "~> 0.6.0"
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "brakeman"
  gem "debug", platforms: %i[mri windows]
end

group :development do
  gem "rubocop"
  gem "rubocop-rails-omakase", require: false
  gem "web-console"
end
