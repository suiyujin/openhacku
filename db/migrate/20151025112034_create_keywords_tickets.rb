class CreateKeywordsTickets < ActiveRecord::Migration
  def change
    create_table :keywords_tickets do |t|
      t.references :keyword, index: true, foreign_key: true, null: false
      t.references :ticket, index: true, foreign_key: true, null: false
    end
  end
end
