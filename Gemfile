source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.3.18'
# gem 'pg', '~> 0.18.4'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# google recaptcha
gem "recaptcha", require: "recaptcha/rails"
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
gem 'remotipart'
gem 'responders', '~> 2.0'

gem 'attr_encrypted'
gem 'aescrypt'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# gem 'jquery-rails', '~> 3.0'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# bxslider
gem 'bxslider-rails'

# auto complete
gem 'rails-jquery-autocomplete'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# brakeman
gem "brakeman", :require => false

# nprogress for Rails
gem 'nprogress-rails'

# bootstrap
gem 'bootstrap-sass', '~> 3.3.6'

# moment js
gem 'momentjs-rails', '>= 2.9.0'

# datetime picker
gem 'bootstrap-datepicker-rails', '~> 1.5'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.37'

gem 'pickadate-rails'

# carrierwave uploader
gem 'carrierwave'

gem 'carrierwave-ftp', :require => 'carrierwave/storage/ftp/all' # both FTP/SFTP

gem 'mini_magick'

# will paginate
gem 'will_paginate'

# fa
gem 'font-awesome-rails'

# breadcrumbs
gem 'breadcrumbs_on_rails'

# underscore
gem 'underscore-rails'

# gmaps
gem 'gmaps4rails'
gem 'rails4-autocomplete'

# Use Unicorn as the app server
# gem 'unicorn'

gem "lazyload-rails"

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# reorganize rails assets
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

if RUBY_VERSION =~ /2.2.3/ # assuming you're running Ruby ~1.9
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end
