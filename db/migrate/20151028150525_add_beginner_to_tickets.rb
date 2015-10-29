class AddBeginnerToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :beginner, :boolean, null: false, default: false
  end
end
