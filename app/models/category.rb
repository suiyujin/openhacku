class Category < ActiveRecord::Base
  has_many :keywords
end
