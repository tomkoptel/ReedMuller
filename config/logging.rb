require 'logger'

Dir.mkdir('log') unless File.exist?('log')

environment = Sinatra::Application.environment.to_sym

logfile = File.new("log/#{environment}.log", 'a+')
logfile.sync = true
Log ||= Logger.new(logfile)

Log.level = Logger::DEBUG
Log.datetime_format = "%Y-%m-%d %H:%M:%S.%L"

unless environment == :test
  STDOUT.reopen(logfile)
end

MullerV1.use Rack::CommonLogger, logfile
