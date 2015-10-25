class MultiLevelOfTicket < ActiveRecord::Migration
  def change
    remove_column :tickets, :level

    create_table :ticket_levels do |t|
      t.integer :level, null: false
      t.references :ticket, index: true, foreign_key: true, null: false
    end
    add_index :ticket_levels, [:level, :ticket_id], unique: true
  end
end
