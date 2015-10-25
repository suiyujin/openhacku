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
p 'categories created.'

# keywords
Keyword.create(make_dummy_data(CSV.read('db/dummy_data/keywords.csv')))
p 'keywords created.'

# users
users = CSV.read('db/dummy_data/users.csv')
User.create(make_dummy_data(users))
p 'users created.'

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
p 'sample tickets created.'

# tickets
Ticket.create(make_dummy_data(CSV.read('db/dummy_data/tickets.csv')))
p 'tickets created.'

# ticket_levels
TicketLevel.create(make_dummy_data(CSV.read('db/dummy_data/ticket_levels.csv')))
p 'ticket_levels created.'

# sample keywords_tickets
tickets_count = Ticket.count
dummy_keywords_tickets = Array.new
1.upto(tickets_count) do |ticket_id|
  1.upto(5) do |num|
    dummy_keywords_tickets << {
      ticket_id: ticket_id,
      keyword_id: num
    }
  end
end
KeywordsTicket.create(dummy_keywords_tickets)
p 'sample keywords_tickets created.'

# keywords_tickets
KeywordsTicket.create(make_dummy_data(CSV.read('db/dummy_data/keywords_tickets.csv')))
p 'keywords_tickets created.'

# sample keywords_users
dummy_keywords_users = Array.new
1.upto(users.size-1) do |user_id|
  1.upto(10) do |num|
    dummy_keywords_users << {
      user_id: user_id,
      keyword_id: (num * user_id)
    }
  end
end
KeywordsUser.create(dummy_keywords_users)
p 'sample keywords_usres created.'
