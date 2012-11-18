require 'simplecov'

if SimpleCov.usable?
  SimpleCov.start do
    add_group "Models", "lib/models"
    add_group "Api", "api/"
    add_filter "/test"
    add_filter "/log"
    add_filter "/spec"
    add_filter "/config"
    add_filter "/coverage"
  end

end
SimpleCov.start

$:.unshift(File.dirname(File.dirname(__FILE__)))

ENV["RACK_ENV"] = "test"

require 'config/environment'
require 'api/v1'
require 'config/logging'

require 'rack/test'
require 'shoulda'
require 'database_cleaner'
#Dir.glob('spec/factories/*.rb').each { |lib| require lib }
#require './spec/mockcached'

# require 'vcr'
# VCR.config do |c|
#   c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
#   c.stub_with :webmock
# end

def fixture(path)
  YAML.load_file("spec/fixtures/#{path}.yml")
end

set :environment, :test

# Run all examples in a transaction
RSpec.configure do |config|
 # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :progress #:documentation :progress, :html, :textmate

  #config.around(:each) do |example|
  #  ActiveRecord::Base.connection.transaction do
  #    example.run
  #    raise ActiveRecord::Rollback
  #  end
  #end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    #$memcached = Mockcached.new
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
