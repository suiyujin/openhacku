# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

def make_dummy_data(data)
  data[1..-1].map { |d| Hash[*data[0].zip(d).flatten] }
end

# categories
Category.create(make_dummy_data(CSV.read('db/dummy_data/categories.csv')))

# keywords
Keyword.create(make_dummy_data(CSV.read('db/dummy_data/keywords.csv')))

# users
users = CSV.read('db/dummy_data/users.csv')
User.create(make_dummy_data(users))

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
    }
  end
end
Ticket.create(dummy_tickets)

# tickets
Ticket.create(make_dummy_data(CSV.read('db/dummy_data/tickets.csv')))

# ticket_levels
TicketLevel.create(make_dummy_data(CSV.read('db/dummy_data/ticket_levels.csv')))

# keywords_tickets
KeywordsTicket.create(make_dummy_data(CSV.read('db/dummy_data/keywords_tickets.csv')))
