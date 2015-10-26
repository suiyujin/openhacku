class AddUniqueIndexToKeywordsUserAndKeywordsTickets < ActiveRecord::Migration
  def change
    add_index :keywords_users, [:keyword_id, :user_id], unique: true
    add_index :keywords_tickets, [:keyword_id, :ticket_id], unique: true
  end
end
