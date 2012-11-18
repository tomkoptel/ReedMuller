require "bundler"
Bundler.require

set :root, File.dirname(File.dirname(__FILE__))

ENV['RACK_ENV'] ||= "development"
environment = ENV['RACK_ENV']

require './api/v1'
require './config/logging'
Dir.glob('./lib/**/*.rb').each { |lib| require lib }
#$memcached = Dalli::Client.new

if ["development", "test"].include? environment
  require "sinatra/base"
  require "sinatra/reloader"

  class MullerV1 < Sinatra::Base
    register Sinatra::Reloader
  end
end
