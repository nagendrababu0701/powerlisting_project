source 'http://rubygems.org'
gem 'geocoder'
gem "omniauth-foursquare"
gem  'foursquare2'
gem 'typhoeus', '0.4.0'
gem 'rails', '3.2.8'
gem "jquery-rails", "~> 2.0.2"
gem "i18n", "~> 0.6.0"
gem "coderay", "~> 1.0.6"
gem "fastercsv", "~> 1.5.0", :platforms => [:mri_18, :mingw_18, :jruby]
gem "builder", "3.0.0"
gem 'yelp'
gem 'mapquest_directions'
gem 'multi_xml'
gem 'hashie'
gem 'mechanize'
gem 'hpricot'
gem 'nokogiri'
gem 'geocoder'
gem 'citygrid'
gem 'httparty'
gem 'oauth'
gem 'ruby-debug'           
gem 'country_select', '1.0.0'
gem 'htmlentities', '4.2.0'
gem "yahoo-placemaker", "~> 0.0.7"
gem 'nas-yahoo_stock'
#gem "yahoo_jp_transit", "~> 0.1.2"
#gem "yahoo-answers"
#gem "yahoofinance-typhoeus", "~> 1.0.0"
#gem "yahoo-local", "~> 0.1.4"
#gem 'yahoo-geocode'
# gem "yahoo-search", "~> 2.0.0"
#gem 'yahoo'
#gem 'mongoid'
#gem 'bson_ext'



# Optional gem for LDAP authentication
group :ldap do
  gem "net-ldap", "~> 0.3.1"
end

# Optional gem for OpenID authentication
group :openid do
  gem "ruby-openid", "~> 2.1.4", :require => "openid"
  gem "rack-openid"
end

# Optional gem for exporting the gantt to a PNG file, not supported with jruby
platforms :mri, :mingw do
  group :rmagick do
    # RMagick 2 supports ruby 1.9
    # RMagick 1 would be fine for ruby 1.8 but Bundler does not support
    # different requirements for the same gem on different platforms
    gem "rmagick", ">= 2.0.0"
  end
end

# Database gems
platforms :mri, :mingw do
  group :postgresql do
    gem "pg", ">= 0.11.0"
  end

  group :sqlite do
    gem "sqlite3"
  end
end

platforms :mri_18, :mingw_18 do
  group :mysql do
    gem "mysql"
  end
end

platforms :mri_19, :mingw_19 do
  group :mysql do
    gem "mysql2", "~> 0.3.11"
  end
end

platforms :jruby do
  gem "jruby-openssl"

  group :mysql do
    gem "activerecord-jdbcmysql-adapter"
  end

  group :postgresql do
    gem "activerecord-jdbcpostgresql-adapter"
  end

  group :sqlite do
    gem "activerecord-jdbcsqlite3-adapter"
  end
end

group :development do
  gem "rdoc", ">= 2.4.2"
  gem "yard"
end

group :test do
  gem "shoulda", "~> 2.11"
  # Shoulda does not work nice on Ruby 1.9.3 and JRuby 1.7.
  # It seems to need test-unit explicitely.
  platforms = [:mri_19]
  platforms << :jruby if defined?(JRUBY_VERSION) && JRUBY_VERSION >= "1.7"
  gem "test-unit", :platforms => platforms
  gem "mocha", "0.12.3"
end

local_gemfile = File.join(File.dirname(__FILE__), "Gemfile.local")
if File.exists?(local_gemfile)
  puts "Loading Gemfile.local ..." if $DEBUG # `ruby -d` or `bundle -v`
  instance_eval File.read(local_gemfile)
end

# Load plugins' Gemfiles
Dir.glob File.expand_path("../plugins/*/Gemfile", __FILE__) do |file|
  puts "Loading #{file} ..." if $DEBUG # `ruby -d` or `bundle -v`
  instance_eval File.read(file)
end
