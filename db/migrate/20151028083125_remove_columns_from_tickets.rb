class RemoveColumnsFromTickets < ActiveRecord::Migration
  def change
    remove_columns :tickets, :sex, :review_min
  end
end
