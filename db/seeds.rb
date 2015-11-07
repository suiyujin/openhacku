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

def make_matching_ticket(user_ids, ticket_id)
  user_ids.map { |user_id| Hash[*['user_id', 'ticket_id'].zip([user_id, ticket_id]).flatten] }
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

# tickets
Ticket.create(make_dummy_data(CSV.read('db/dummy_data/tickets.csv')))
p 'tickets created.'

# keywords_tickets
KeywordsTicket.create(make_dummy_data(CSV.read('db/dummy_data/keywords_tickets.csv')))
p 'keywords_tickets created.'

# keywords_users
KeywordsUser.create(make_dummy_data(CSV.read('db/dummy_data/keywords_users.csv')))
p 'keywords_users created.'

# reviews
Review.create(make_dummy_data(CSV.read('db/dummy_data/reviews.csv')))
p 'reviews created.'

# Userのreview_aveを更新
to_users = Review.select(:to_user_id).map(&:to_user_id).uniq
to_users.each do |to_user_id|
  to_user = User.find(to_user_id)
  scores = to_user.review_users_of_to_user.map(&:score)
  review_ave = scores.blank? ? nil : (scores.inject(&:+) / scores.count.to_f).round(1)
  to_user.update_attribute(:review_ave, review_ave)
end
p "calculate user review average."

# sample stock_tickets
dummy_stock_tickets = Array.new
1.upto(users.size-1) do |user_id|
  1.upto(5) do |num|
    dummy_stock_tickets << {
      user_id: user_id,
      ticket_id: (num * user_id)
    }
  end
end
StockTicket.create(dummy_stock_tickets)
p 'sample stock_tickets created.'


# ticket_candidates
TicketCandidate.create(make_dummy_data(CSV.read('db/dummy_data/ticket_candidates.csv')))
p 'ticket_candidates created.'

# matching_tickets
Ticket.includes(:keywords).select(:id, :user_id).each do |ticket|
  matching_user_ids = MatchingTicket.search_matching_user(ticket)
  MatchingTicket.create(make_matching_ticket(matching_user_ids, ticket.id))
end
p 'matching_tickets created.'
