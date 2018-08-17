$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "mongoid_localized_presence_validator"

require "bundler/setup"
require "database_cleaner"
require "minitest"
require "minitest/autorun"
require "minitest/spec"
require "mongoid"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

Mongoid.logger.level = Logger::INFO
Mongo::Logger.logger.level = Logger::INFO

Mongoid.configure do |config|
  config.connect_to("mongoid_localized_presence_validator")
end

DatabaseCleaner.orm = :mongoid
DatabaseCleaner.strategy = :truncation

class MiniTest::Spec
  before(:each) do
    DatabaseCleaner.start
  end

  after(:each) do
    DatabaseCleaner.clean
  end
end
