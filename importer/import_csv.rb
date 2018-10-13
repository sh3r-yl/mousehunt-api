require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'sequel'
  gem 'pg'
end

require 'csv'

# Connect to the database
# Format for connection is postgres://<username>:<password>@<host>:<port>/<database_name>
DB = Sequel.connect('postgres://nsuguryurduito:fd48d751a78162d4f28c898d170a05469e55da409b88f7f46d31c7d2f0fad323@ec2-54-225-110-152.compute-1.amazonaws.com:5432/d9pip0548a3dr5')

# puts 'importing rodents...'
#
# # Read the CSV file for mice
# mice_csv = File.join(File.dirname(__FILE__), '/Mousehunt - Mice.csv')
#
# # The table name in postgres
# rodents_table = DB[:rodents]
#
# # Contents of the CSV file
# mice_csv_contents = CSV.read(mice_csv)
#
# # Ignore the header of the CSV
# mice_csv_contents.shift
#
# # Import
# mice_csv_contents.each do |row|
#   mouse_name = row[0]&.strip
#   mouse_points = row[2]&.gsub(/[^0-9]/,'').to_i
#   mouse_gold = row[3]&.gsub(/[^0-9]/,'').to_i
#   mouse_group = row[5]&.strip
#   mouse_sub_group = row[6]&.strip
#
#   puts "Adding #{mouse_name}"
#
#   rodents_table.insert(
#     name: mouse_name,
#     points: mouse_points,
#     gold: mouse_gold,
#     group: mouse_group,
#     subgroup: mouse_sub_group
#   )
# end

puts 'importing locations...'

# Read the CSV file for Locations
locations_csv = File.join(File.dirname(__FILE__), '/Mousehunt - Locations.csv')

# The table name in postgres
locations_table = DB[:locations]

# Contents of the CSV file
locations_csv_contents = CSV.read(locations_csv)

# Ignore the header of the CSV
locations_csv_contents.shift

# Import
locations_csv_contents.each do |row|
  loc_name = row[0]&.strip
  loc_region = row[1]&.strip
  loc_min_title = row[2]&.strip
  loc_travel_req = row[3]&.strip
  lose_gold = row[4]&.strip
  lose_points = row[5]&.strip
  lose_cheese = row[6]&.strip

  puts "Adding #{loc_name}"

  locations_table.insert(
    name: loc_name,
    region: loc_region,
    minimum_title: loc_min_title,
    travel_requirements: loc_travel_req,
    lose_gold: lose_gold,
    lose_points: lose_points,
    lose_cheese: lose_cheese
  )
end

def str_to_bool(str)
  str == 'Yes' ? true : false
end
