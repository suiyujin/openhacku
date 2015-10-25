class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :bought_user, class_name: 'User'
  has_many :stock_tickets, dependent: :delete_all

  scope :user, ->(user_id) { where(user_id: user_id) }
  scope :bought_user, ->(bought_user_id) { where(bought_user_id: bought_user_id) }
  scope :bought, -> { where(bought: true) }
  scope :no_bought, -> { where(bought: false) }
  scope :order_limit_offset, ->(order, limit, offset) { order(order).limit(limit).offset(offset) }
end
