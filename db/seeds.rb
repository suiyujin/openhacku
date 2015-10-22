# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

# users
users = CSV.read('db/dummy_data/users.csv')
User.create(users[1..-1].map { |user| Hash[*users[0].zip(user).flatten] })
