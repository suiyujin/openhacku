class RenamePlaceToOfflinePlaceFromTickets < ActiveRecord::Migration
  def change
    rename_column :tickets, :place, :offline_place
  end
end
