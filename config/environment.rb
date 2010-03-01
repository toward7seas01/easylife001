# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')



Rails::Initializer.run do |config|
  config.load_paths += %W[#{RAILS_ROOT}/app/sweeper]
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on.
  # They can then be installed with "rake gems:install" on new installations.
  # You have to specify the :lib option for libraries, where the Gem name (sqlite3-ruby) differs from the file itself (sqlite3)
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem 'javan-whenever', :lib => false, :source => 'http://gems.github.com'
  config.gem 'nokogiri', :lib => false
  #  config.gem 'scrapi'
  #  config.gem 'vestal_versions'

#  config.action_controller.page_cache_directory = RAILS_ROOT + "/public/cache/"

  # Only load the plugins named here, in the order given. By default, all plugins
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Comment line to use default local time.
  config.time_zone = 'Beijing'

  # The internationalization framework can be changed to have another default locale (standard is :en) or more load paths.
  # All files from config/locales/*.rb,yml are added automatically.
  #  config.i18n.load_path << Dir[File.join(RAILS_ROOT, 'locales', '*.{rb,yml}')]
  config.i18n.default_locale = 'zh-CN'

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random,
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_knight_session',
    :secret      => '2430dac045e1acd6c4eca88f0be9db0b920dda3908b99b0003549f78fae4392adda6dbec4c5b1940dd62b71b0c76575e4cea9efca4ae3d5d27b1f2de73e91f8d'
  }

  config.action_view.sanitized_allowed_tags = %w(table tr td span br strong em p sub sup img ul li ol q)
  config.action_view.sanitized_allowed_attributes = %w(font id class style border src width height data type name value)

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # Please note that observers generated using script/generate observer need to have an _observer suffix
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :tls => true,
    :address => "smtp.gmail.com",
    :port => "587",
    :authentication => :plain,
    :user_name => "easylife37@gmail.com",
    :password => "12121212"
  }
  
  #  config.action_controller.session[:domain] = DEFAULT_ROOT_DOMAIN
end

def call_rake(task, options = {})
  args = options.map do |k, v| "#{k.to_s.upcase}=#{v}" end
  system("rake #{task} #{args.join(" ")} &")
end



