class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :bought_user, class_name: 'User'

  scope :order_limit_offset, ->(limit, offset) { order(id: :desc).limit(limit).offset(offset) }
end
