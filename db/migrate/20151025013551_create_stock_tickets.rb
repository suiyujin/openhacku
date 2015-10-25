class CreateStockTickets < ActiveRecord::Migration
  def change
    create_table :stock_tickets do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :ticket, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
    add_index :stock_tickets, [:user_id, :ticket_id], unique: true
  end
end
