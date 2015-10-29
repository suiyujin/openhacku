class Keyword < ActiveRecord::Base
  belongs_to :category
  has_many :keywords_users
  has_many :users, through: :keywords_users
  has_many :keywords_tickets
  has_many :tickets, through: :keywords_tickets

  scope :category, ->(category_id) { where(category_id: category_id) }
end
