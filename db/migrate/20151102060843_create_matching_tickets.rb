class CreateMatchingTickets < ActiveRecord::Migration
  def change
    create_table :matching_tickets do |t|
      t.boolean :read_flag, null: false, default: false
      t.references :ticket, null: false, index: true, foreign_key: true
      t.references :user, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :matching_tickets, [:ticket_id, :user_id], unique: true
  end
end
