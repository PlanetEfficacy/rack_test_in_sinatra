ENV["RACK_ENV"] ||= "test"
require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'database_cleaner'
require 'rack/test'



DatabaseCleaner.strategy = :truncation, {except: %w([public.schema.migrations])}

module TestHelpers
  include Rack::Test::Methods
  def app     # def app is something that Rack::Test is looking for
    ToDoApp
  end

  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end
end
