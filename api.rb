require 'sinatra'
require 'json'

require_relative 'models/rodent'
require_relative 'models/location'

get '/' do
  "Sheryl's MouseHunt API"
end

get '/rodents/?' do
  content_type :json
  Rodent.all.to_json
end

get '/locations/?' do
  content_type :json
  Location.all.to_json
end
