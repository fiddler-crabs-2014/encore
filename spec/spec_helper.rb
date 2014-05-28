require 'simplecov'
require 'capybara/rspec'
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/lib/'
  add_filter '/vendor/'
  add_filter '/services/'
  add_filter '/uploaders/'
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.include WaitForAjax, type: :feature
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
  config.include OmniAuthTestHelper, type: :feature
  config.include OmniAuthTestHelper, type: :controller
  OmniAuth.config.test_mode = true
  omniauth_hash = {
        provider: 'facebook',
        uid: '123545',
        info: {
          first_name: "Jared",
          last_name:  "Rader",
          email:      "test@example.com"
        },
        credentials: {
          token: "123456",
          expires_at: Time.now + 1.week
        }
      }
  OmniAuth.config.add_mock(:facebook, omniauth_hash)
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end
