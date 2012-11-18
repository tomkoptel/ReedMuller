class MullerV1 < Sinatra::Base
  set :root, "#{File.dirname(__FILE__)}/v1"

  get %r{/muller/(\d+)} do |rate|
    content_type :json

    reed_muller = ReedMuller.new(rate)
    response = {:matrix => reed_muller.calculate()}
    response.to_json
  end
end
