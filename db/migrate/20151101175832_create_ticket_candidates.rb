class CreateTicketCandidates < ActiveRecord::Migration
  def change
    create_table :ticket_candidates do |t|
      t.string :comment
      t.references :ticket, null: false, index: true, foreign_key: true
      t.references :user, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
