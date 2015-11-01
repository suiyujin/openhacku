class RenameHangoutToHangouts < ActiveRecord::Migration
  def change
    rename_column :tickets, :hangout, :hangouts
  end
end
