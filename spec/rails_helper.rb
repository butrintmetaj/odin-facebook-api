require File.expand_path('../config/environment', __dir__)
ENV['RAILS_ENV'] ||= 'test'
require 'rspec/rails'
require 'spec_helper'
include ActiveJob::TestHelper


FactoryBot::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
end

abort('The Rails environment is running in production mode!') if Rails.env.production?

Dir[File.dirname(__FILE__) + "/support/*.rb"].each {|f| require f }

ActiveRecord::Migration.maintain_test_schema!
ActiveJob::Base.queue_adapter = :test
FactoryBot.rewind_sequences

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
  config.include AuthHelper, type: :request
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end