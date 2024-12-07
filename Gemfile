source "https://rubygems.org"

ruby file: ".ruby-version"

gem "bootsnap", require: false
gem "dotenv", "~> 3.1"
gem "importmap-rails"
gem "kamal"
gem "ostruct", "~> 0.6.0"
gem "propshaft"
gem "puma"
gem "rails", "~> 8.0"
gem "redis"
gem "sidekiq"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "thruster", "~> 0.1.9"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "brakeman"
  gem "debug", platforms: %i[mri windows]
  gem "ruby-lsp"
end

group :development do
  gem "rubocop"
  gem "rubocop-rails-omakase", require: false
  gem "web-console"
end
