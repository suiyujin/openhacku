class AddColumnsToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :header_img_url, :string, null: false, default: 'http://210.140.71.3/image/tickets/header/keyboard.jpg'
    add_column :tickets, :ticket_img_url, :string, null: false, default: 'http://210.140.71.3/image/tickets/ticket/keyboard.jpg'
  end
end
