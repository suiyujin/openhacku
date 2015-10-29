class KeywordsTicket < ActiveRecord::Base
  belongs_to :keyword
  belongs_to :ticket
end
