class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :bought_user, class_name: 'User'
  has_many :stock_tickets, dependent: :delete_all
  has_many :keywords_tickets, dependent: :delete_all
  has_many :keywords, through: :keywords_tickets

  scope :user, ->(user_id) { where(user_id: user_id) }
  scope :bought_user, ->(bought_user_id) { where(bought_user_id: bought_user_id) }
  scope :bought, -> { where(bought: true) }
  scope :no_bought, -> { where(bought: false) }
  scope :joins_stock_tickets_where_user, ->(user_id) { joins(:stock_tickets).where(stock_tickets: { user_id: user_id }) }
  scope :order_limit_offset, ->(order, limit, offset) { order(order).limit(limit).offset(offset) }
end
