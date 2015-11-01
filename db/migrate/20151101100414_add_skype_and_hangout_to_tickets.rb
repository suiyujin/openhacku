class AddSkypeAndHangoutToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :skype, :boolean, null: false, default: false
    add_column :tickets, :hangout, :boolean, null: false, default: false
  end
end
