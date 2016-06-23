# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

puts 'DEFAULT USERS'
user = Admin.create! :username => "edugonch", :email => "edugonch@gmail.com", :password => "5588abk7z1", :password_confirmation => "5588abk7z1"

puts 'user: ' << user.name
