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

# sample tickets
dummy_tickets = Array.new
1.upto(users.size-1) do |user_id|
  1.upto(5) do |num|
    dummy_tickets << {
      title: "title#{user_id}#{num}",
      body: "body#{user_id}#{num}",
      time: [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0].sample,
      price: [1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000].sample,
      place: ["オンライン", "新宿", "渋谷", "つくば"].sample,
      user_id: user_id,
      sex: [0, 1, 2].sample,
      review_min: Random.rand(0.0..5.0).round(1),
      level: [0, 1, 2].sample
    }
  end
end
Ticket.create(dummy_tickets)

# tickets
tickets = CSV.read('db/dummy_data/tickets.csv')
Ticket.create(tickets[1..-1].map { |ticket| Hash[*tickets[0].zip(ticket).flatten] })
