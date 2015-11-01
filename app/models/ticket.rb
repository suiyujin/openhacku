class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :bought_user, class_name: 'User'
  has_many :stock_tickets, dependent: :delete_all
  has_many :keywords_tickets, dependent: :delete_all
  has_many :keywords, through: :keywords_tickets
  has_one :review

  scope :user, ->(user_id) { where(user_id: user_id) }
  scope :bought_user, ->(bought_user_id) { where(bought_user_id: bought_user_id) }
  scope :bought, -> { where(bought: true) }
  scope :no_bought, -> { where(bought: false) }
  scope :beginner, -> { where(beginner: true) }
  scope :no_beginner, -> { where(beginner: false) }
  scope :online, -> { where('skype OR hangout') }
  scope :offline, -> { where.not(offline_place: nil) }
  scope :ticket_ids, ->(ticket_ids) { where(id: ticket_ids) }
  scope :joins_stock_tickets_where_user, ->(user_id) { joins(:stock_tickets).where(stock_tickets: { user_id: user_id }) }
  scope :joins_users_where_sex, ->(sex) { joins(:user).where(users: { sex: sex }) }
  scope :order_limit_offset, ->(order, limit, offset) { order(order).limit(limit).offset(offset) }
  scope :search, ->(query) { where("tickets.title LIKE '%#{query}%' OR tickets.body LIKE '%#{query}%'") }
  scope :search_with_in, ->(keyword_ticket_ids, query) { where("tickets.id IN (#{keyword_ticket_ids}) OR tickets.title LIKE '%#{query}%' OR tickets.body LIKE '%#{query}%'") }
end
