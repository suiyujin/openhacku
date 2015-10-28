class DropTicketLevels < ActiveRecord::Migration
  def change
    drop_table :ticket_levels
  end
end
