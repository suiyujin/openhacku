class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :bought_user, class_name: 'User'

  scope :order_limit_offset, ->(order, limit, offset) { order(order).limit(limit).offset(offset) }
end
