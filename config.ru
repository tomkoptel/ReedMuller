$:.unshift(File.dirname(__FILE__))
require "rubygems"
require "bundler"
Bundler.require

set :environment, ENV['RACK_ENV'].to_sym

require 'config/environment'

require 'api/v1'
require 'rack/contrib'

ENV['RACK_ENV'] ||= 'development'


#use Rack::CommonLogger


map "/api/v1" do
  use Rack::PostBodyContentTypeParser
  use Rack::MethodOverride
  run MullerV1
end


test = lambda do |env|
  info = {"ENV['RACK_ENV']" => ENV['RACK_ENV']}
  return [200, {"Content-Type" => "application/json"}, [info.to_json]]
end

map '/test' do
  run test
end

