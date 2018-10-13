require 'sinatra'
require 'json'

require_relative 'models/rodent'

get '/' do
  "Sheryl's MouseHunt API"
end

get '/rodents/?' do
  content_type :json
  Rodent.all.to_json
end
