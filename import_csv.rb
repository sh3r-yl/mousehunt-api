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

puts 'importing rodents...'

# Read the CSV file for mice
mice_csv = File.join(File.dirname(__FILE__), '/mice.csv')

# The table name in postgres
rodents_table = DB[:rodents]

# Contents of the CSV file
mice_csv_contents = CSV.read(mice_csv)

# Ignore the header of the CSV
mice_csv_contents.shift

# Import
mice_csv_contents.each do |row|
  mouse_name = row[0]&.strip
  mouse_points = row[2]&.gsub(/[^0-9]/,'').to_i
  mouse_gold = row[3]&.gsub(/[^0-9]/,'').to_i
  mouse_group = row[5]&.strip
  mouse_sub_group = row[6]&.strip

  puts "Adding #{mouse_name}"

  rodents_table.insert(
    name: mouse_name,
    points: mouse_points,
    gold: mouse_gold,
    group: mouse_group,
    subgroup: mouse_sub_group
  )
end