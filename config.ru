require 'dotenv/load'
require 'sequel'
require 'pg'

Sequel.connect(ENV.fetch('DATABASE_URL'))

require './api'
run Sinatra::Application
