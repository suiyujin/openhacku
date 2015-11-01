class ChangeNullTrueForOfflinePlaceFromTickets < ActiveRecord::Migration
  def change
    change_column :tickets, :offline_place, :string, null: true
  end
end
