class Keyword < ActiveRecord::Base
  belongs_to :category

  scope :category, ->(category_id) { where(category_id: category_id) }
end
