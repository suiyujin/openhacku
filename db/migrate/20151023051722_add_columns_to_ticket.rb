class AddColumnsToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :sex, :integer, null: false
    add_column :tickets, :review_min, :float, null: false
    add_column :tickets, :level, :integer, null: false
  end
end
